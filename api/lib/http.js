const axios = require('axios');

// A realistic desktop browser UA. Rotating a small pool reduces trivial UA-based blocking.
const USER_AGENTS = [
  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
  'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
];

function pickUserAgent() {
  return USER_AGENTS[Math.floor(Math.random() * USER_AGENTS.length)];
}

/**
 * Fetch a public HTML page with sane defaults.
 * Only ever call this on publicly accessible product listing pages.
 */
async function fetchHtml(url, { timeout = 8000, extraHeaders = {} } = {}) {
  const response = await axios.get(url, {
    timeout,
    headers: {
      'User-Agent': pickUserAgent(),
      'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'en-IN,en;q=0.9',
      ...extraHeaders,
    },
    validateStatus: (status) => status < 500, // let us handle 4xx explicitly
  });

  if (response.status === 403 || response.status === 429) {
    const err = new Error(`Blocked by upstream (status ${response.status})`);
    err.code = 'BLOCKED';
    throw err;
  }
  if (response.status >= 400) {
    const err = new Error(`Upstream returned status ${response.status}`);
    err.code = 'HTTP_ERROR';
    throw err;
  }
  return response.data;
}

module.exports = { fetchHtml, pickUserAgent };
