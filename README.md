# ai_price_comparision

A Flutter price-comparison app, backed by our own in-house scraping API
(no more SerpApi dependency).

## Repo layout

- `lib/` — Flutter app (web/android/ios)
- `api/` — Node.js backend, deployed as Vercel Serverless Functions
  - `api/search.js` — `GET /api/search?q=<query>` → unified JSON of results from all sources
  - `api/health.js` — `GET /api/health` health check
  - `api/scrapers/{amazon,flipkart,croma}.js` — one module per site, each split into a `fetch` step and a pure `parse(html)` step
  - `api/lib/` — shared cache, rate-limiter, and HTTP client helpers
- `scripts/dev-server.js` — run the API locally without the Vercel CLI: `npm run dev`
- `scripts/test-parsers.js` + `fixtures/*.html` — offline parser tests: `npm test`

## Backend: run locally

```
npm install
npm test          # validates each scraper's parse() against fixture HTML
npm run dev        # starts http://localhost:3000, try /api/search?q=iphone
```

## Flutter: pointing at the backend

The backend base URL is **not hardcoded** — it's read from `AppConfig`
(`lib/core/app_config.dart`), overridable via `--dart-define`:

```
flutter run --dart-define=API_BASE_URL=http://localhost:3000/api
flutter build web --dart-define=API_BASE_URL=https://<your-vercel-app>.vercel.app/api
```

If no `API_BASE_URL` is passed, it defaults to the production Vercel URL
baked into `AppConfig`.

## Deploying

Both the Flutter web build and the `/api` serverless functions deploy
together from a single Vercel project (see `vercel.json`). If Vercel's own
build image can't run `flutter build web`, `.github/workflows/deploy.yml`
builds it in GitHub Actions and deploys the prebuilt output instead — it
needs `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID` repo secrets.

## Notes / limitations

- Scrapers only read publicly accessible search-result pages (no login,
  no paid endpoints). Site markup changes over time, so a scraper going
  quiet on one source doesn't take down the others — `/api/search` reports
  per-source errors in `data.sourceErrors` and still returns whatever
  succeeded.
- There's an old SerpApi key checked into git history — it was already
  exposed before this change; consider rotating/revoking it on the SerpApi
  dashboard regardless.

## Getting Started (Flutter)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

