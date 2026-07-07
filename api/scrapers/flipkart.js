const cheerio = require('cheerio');
const { fetchHtml } = require('../lib/http');

const SOURCE = 'Flipkart';

function buildSearchUrl(query) {
  return `https://www.flipkart.com/search?q=${encodeURIComponent(query)}`;
}

/**
 * Flipkart renders several different card layouts depending on category
 * (electronics grid vs generic list). We try a couple of known selector
 * sets and take whichever yields results.
 */
function parse(html) {
  const $ = cheerio.load(html);
  const results = [];

  const cardSelectors = ['div._1AtVbE', 'div._4ddWXP', 'div._2kHMtA'];

  for (const selector of cardSelectors) {
    $(selector).each((_, el) => {
      try {
        const node = $(el);

        const title =
          node.find('div._4rR01T').text().trim() ||
          node.find('a.IRpwTa').text().trim() ||
          node.find('a.s1Q9rs').attr('title');

        const priceText = node.find('div._30jeq3').first().text().trim();
        const linkRel = node.find('a').first().attr('href');

        if (!title || !priceText || !linkRel) return;

        const priceNum = Number(priceText.replace(/[^0-9]/g, ''));
        if (!priceNum) return;

        const url = linkRel.startsWith('http') ? linkRel : `https://www.flipkart.com${linkRel}`;
        const image = node.find('img').first().attr('src') || '';

        // De-dupe across selector passes (same product can match >1 selector).
        if (results.some((r) => r.url === url)) return;

        results.push({
          source: SOURCE,
          title,
          price: `\u20b9${priceNum.toLocaleString('en-IN')}`,
          extractedPrice: priceNum,
          image,
          url,
          rating: node.find('div._3LWZlK').first().text().trim() || null,
        });
      } catch (e) {
        // Skip malformed card
      }
    });
    if (results.length > 0) break;
  }

  return results;
}

async function search(query) {
  const html = await fetchHtml(buildSearchUrl(query));
  return parse(html);
}

module.exports = { search, parse, buildSearchUrl, SOURCE };
