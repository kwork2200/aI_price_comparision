// Minimal local dev server that mimics Vercel's file-based /api routing,
// so we can test the handlers with `node scripts/dev-server.js` without
// needing the Vercel CLI installed.
const http = require('http');
const url = require('url');

const searchHandler = require('../api/search');
const healthHandler = require('../api/health');

const PORT = process.env.PORT || 3000;

function withHelpers(req, res) {
  const parsed = url.parse(req.url, true);
  req.query = parsed.query;

  const originalJson = (body) => {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(body));
  };
  res.status = (code) => {
    res.statusCode = code;
    return { json: originalJson, end: () => res.end() };
  };
}

const server = http.createServer(async (req, res) => {
  withHelpers(req, res);
  const pathname = url.parse(req.url).pathname;

  try {
    if (pathname === '/api/search') {
      await searchHandler(req, res);
    } else if (pathname === '/api/health') {
      await healthHandler(req, res);
    } else {
      res.status(404).json({ success: false, error: 'Not found' });
    }
  } catch (err) {
    console.error('Handler error:', err);
    res.status(500).json({ success: false, error: 'Internal server error' });
  }
});

server.listen(PORT, () => {
  console.log(`Local dev API listening on http://localhost:${PORT}`);
  console.log(`Try: http://localhost:${PORT}/api/search?q=iphone`);
});
