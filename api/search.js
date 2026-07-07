const amazon = require('./scrapers/amazon');
const flipkart = require('./scrapers/flipkart');
const croma = require('./scrapers/croma');
const cache = require('./lib/cache');
const { checkRateLimit } = require('./lib/rateLimit');

const SCRAPERS = [amazon, flipkart, croma];
const CACHE_TTL_MS = 5 * 60 * 1000; // 5 minutes

function setCors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
}

module.exports = async function handler(req, res) {
  setCors(res);

  if (req.method === 'OPTIONS') {
    res.status(204).end();
    return;
  }

  if (req.method !== 'GET') {
    res.status(405).json({ success: false, error: 'Method not allowed. Use GET.' });
    return;
  }

  const query = (req.query?.q || '').toString().trim();
  if (!query) {
    res.status(400).json({ success: false, error: 'Missing required query param "q".' });
    return;
  }
  if (query.length > 200) {
    res.status(400).json({ success: false, error: 'Query too long.' });
    return;
  }

  const rl = checkRateLimit(req);
  if (!rl.allowed) {
    res.setHeader('Retry-After', Math.ceil(rl.retryAfterMs / 1000));
    res.status(429).json({ success: false, error: 'Rate limit exceeded. Try again shortly.' });
    return;
  }

  const cacheKey = `search:${query.toLowerCase()}`;
  const cached = cache.get(cacheKey);
  if (cached) {
    res.status(200).json({ success: true, cached: true, data: cached });
    return;
  }

  const settled = await Promise.allSettled(SCRAPERS.map((s) => s.search(query)));

  const results = [];
  const errors = [];

  settled.forEach((outcome, i) => {
    const sourceName = SCRAPERS[i].SOURCE;
    if (outcome.status === 'fulfilled') {
      results.push(...outcome.value);
    } else {
      errors.push({ source: sourceName, message: outcome.reason?.message || 'Unknown error' });
    }
  });

  // Sort cheapest first, keep unpriced items (shouldn't happen given parser filters) at the end.
  results.sort((a, b) => (a.extractedPrice || Infinity) - (b.extractedPrice || Infinity));

  const responseBody = {
    query,
    results,
    sourcesQueried: SCRAPERS.map((s) => s.SOURCE),
    sourceErrors: errors, // per-source failures, isolated so one blocked site doesn't fail the whole request
  };

  // Only cache non-empty results, so a transient all-sources failure doesn't get "stuck" cached.
  if (results.length > 0) {
    cache.set(cacheKey, responseBody, CACHE_TTL_MS);
  }

  res.status(200).json({ success: true, cached: false, data: responseBody });
};
