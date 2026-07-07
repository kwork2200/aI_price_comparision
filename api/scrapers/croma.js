const cheerio = require('cheerio');
const { fetchHtml } = require('../lib/http');

const SOURCE = 'Croma';

function buildSearchUrl(query) {
  return `https://www.croma.com/searchB?q=${encodeURIComponent(query)}%3Arelevance&text=${encodeURIComponent(
    query
  )}`;
}

function parse(html) {
  const $ = cheerio.load(html);
  const results = [];

  $('li.product-item, div.product-item').each((_, el) => {
    try {
      const node = $(el);

      const title = node.find('h3').first().text().trim();
      const priceText = node
        .find('span[class*="amount"], span[class*="price"]')
        .first()
        .text()
        .trim();
      const linkRel = node.find('a').first().attr('href');

      if (!title || !priceText || !linkRel) return;

      const priceNum = Number(priceText.replace(/[^0-9]/g, ''));
      if (!priceNum) return;

      const url = linkRel.startsWith('http') ? linkRel : `https://www.croma.com${linkRel}`;
      const image = node.find('img').first().attr('src') || node.find('img').first().attr('data-src') || '';

      results.push({
        source: SOURCE,
        title,
        price: `\u20b9${priceNum.toLocaleString('en-IN')}`,
        extractedPrice: priceNum,
        image,
        url,
        rating: null,
      });
    } catch (e) {
      // Skip malformed card
    }
  });

  return results;
}

async function search(query) {
  const html = await fetchHtml(buildSearchUrl(query));
  return parse(html);
}

module.exports = { search, parse, buildSearchUrl, SOURCE };
