// Basic fixed-window rate limiter, keyed by client IP.
// Good enough to blunt accidental hammering; not a substitute for a real
// gateway-level limiter if traffic grows.
const hits = new Map();

const WINDOW_MS = 60 * 1000; // 1 minute
const MAX_REQUESTS = 30; // per IP per window

function getClientIp(req) {
  const forwarded = req.headers['x-forwarded-for'];
  if (forwarded) return forwarded.split(',')[0].trim();
  return req.socket?.remoteAddress || 'unknown';
}

function checkRateLimit(req) {
  const ip = getClientIp(req);
  const now = Date.now();
  const entry = hits.get(ip);

  if (!entry || now > entry.resetAt) {
    hits.set(ip, { count: 1, resetAt: now + WINDOW_MS });
    return { allowed: true, remaining: MAX_REQUESTS - 1 };
  }

  if (entry.count >= MAX_REQUESTS) {
    return { allowed: false, remaining: 0, retryAfterMs: entry.resetAt - now };
  }

  entry.count += 1;
  return { allowed: true, remaining: MAX_REQUESTS - entry.count };
}

module.exports = { checkRateLimit };
