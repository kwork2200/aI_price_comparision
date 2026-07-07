// Offline tests for the pure parse() functions in each scraper, run against
// saved fixture HTML. This validates parsing logic without needing live
// network access to the actual e-commerce sites.
const fs = require('fs');
const path = require('path');

const amazon = require('../api/scrapers/amazon');
const flipkart = require('../api/scrapers/flipkart');
const croma = require('../api/scrapers/croma');

let failures = 0;

function assert(condition, message) {
  if (!condition) {
    failures += 1;
    console.error(`FAIL: ${message}`);
  } else {
    console.log(`PASS: ${message}`);
  }
}

function loadFixture(name) {
  return fs.readFileSync(path.join(__dirname, '..', 'fixtures', name), 'utf8');
}

function testAmazon() {
  const html = loadFixture('amazon-sample.html');
  const results = amazon.parse(html);
  assert(results.length === 2, `Amazon: expected 2 priced results, got ${results.length}`);
  assert(results[0].title.includes('iPhone 15'), 'Amazon: first result title parsed');
  assert(results[0].extractedPrice === 64999, `Amazon: first price parsed as 64999, got ${results[0].extractedPrice}`);
  assert(results[0].url.startsWith('https://www.amazon.in/dp/'), 'Amazon: relative URL resolved to absolute');
  assert(results[1].url === 'https://www.amazon.in/dp/B0EXAMPLE2', 'Amazon: absolute URL kept as-is');
}

function testFlipkart() {
  const html = loadFixture('flipkart-sample.html');
  const results = flipkart.parse(html);
  assert(results.length === 2, `Flipkart: expected 2 results, got ${results.length}`);
  assert(results[0].extractedPrice === 65999, `Flipkart: first price parsed as 65999, got ${results[0].extractedPrice}`);
  assert(results[0].url.startsWith('https://www.flipkart.com/'), 'Flipkart: relative URL resolved to absolute');
}

function testCroma() {
  const html = loadFixture('croma-sample.html');
  const results = croma.parse(html);
  assert(results.length === 2, `Croma: expected 2 results, got ${results.length}`);
  assert(results[0].extractedPrice === 66499, `Croma: first price parsed as 66499, got ${results[0].extractedPrice}`);
  assert(results[1].url === 'https://www.croma.com/apple-iphone-15-256gb-black-p123457', 'Croma: absolute URL kept as-is');
}

testAmazon();
testFlipkart();
testCroma();

if (failures > 0) {
  console.error(`\n${failures} test(s) failed.`);
  process.exit(1);
} else {
  console.log('\nAll parser tests passed.');
}
