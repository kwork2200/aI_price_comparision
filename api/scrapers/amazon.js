const cheerio = require('cheerio');
const { fetchHtml } = require('../lib/http');

const SOURCE = 'Amazon';

function buildSearchUrl(query) {
  return `https://www.amazon.in/s?k=${encodeURIComponent(query)}`;
}

/**
 * Pure parse function: takes raw HTML string, returns array of results.
 * Kept separate from fetching so it can be unit-tested against fixture HTML
 * without needing network access.
 */
function parse(html) {
  const $ = cheerio.load(html);
  const results = [];

  $('div[data-component-type="s-search-result"]').each((_, el) => {
    try {
      const node = $(el);

      const title =
        node.find('h2 a span').first().text().trim() ||
        node.find('h2 span').first().text().trim();

      const relativeLink = node.find('h2 a').attr('href');
      if (!title || !relativeLink) return;

      const url = relativeLink.startsWith('http')
        ? relativeLink
        : `https://www.amazon.in${relativeLink}`;

      const priceWhole = node.find('span.a-price-whole').first().text().replace(/[^0-9]/g, '');
      if (!priceWhole) return; // skip sponsored/no-price cards

      const image = node.find('img.s-image').attr('src') || '';
      const ratingText = node.find('span.a-icon-alt').first().text().trim();
      const rating = ratingText ? ratingText.split(' ')[0] : null;

      results.push({
        source: SOURCE,
        title,
        price: `\u20b9${Number(priceWhole).toLocaleString('en-IN')}`,
        extractedPrice: Number(priceWhole),
        image,
        url,
        rating,
      });
    } catch (e) {
      // Skip malformed individual card, keep going.
    }
  });

  return results;
}

async function search(query) {
  const html = await fetchHtml(buildSearchUrl(query));
  return parse(html);
}

module.exports = { search, parse, buildSearchUrl, SOURCE };
