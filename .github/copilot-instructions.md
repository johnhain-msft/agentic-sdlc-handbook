# Copilot Instructions — agentic-sdlc-handbook

## Project overview

This is a Quarto book ("The Agentic SDLC Handbook") published to GitHub Pages at `danielmeppiel.github.io/agentic-sdlc-handbook/`. It covers AI-native software development methodology, the PROSE framework, and APM.

## Build & deploy workflow

### CI builds all three formats

`.github/workflows/publish.yml` runs on every push to `main` that can change the book. A push that only touches `worksheets/`, `docs/` or `.github/` does not trigger it, unless it changes `publish.yml` itself. It can also be run by hand from the Actions tab.

Its jobs:

1. `build-deploy` renders HTML (`quarto render --to html`), carries the current PDF and EPUB across from `gh-pages`, and publishes. It takes about a minute.
2. `downloads` runs alongside it. It renders the PDF and EPUB on the runner, with TinyTeX for LaTeX and Chrome Headless Shell for Mermaid→PNG. It then runs `scripts/strip-blank-page.py` as a guard, in case the web-only download chapter ever appears in them.
3. `deploy-downloads` commits the new PDF and EPUB to `gh-pages` once both jobs pass.

If `downloads` fails, the site still updates with the previous PDF and EPUB, and the run shows red. Only `main` deploys. A manual run with **deploy** unticked builds the PDF and EPUB and uploads them as an artifact without publishing anything.

### PDF & EPUB on your own machine (optional)

```bash
./scripts/build-downloads.sh   # needs Quarto, TinyTeX and Chrome
./scripts/publish.sh           # pushes them to gh-pages and tags the version
```

CI makes this unnecessary for routine changes. The scripts are for a release you want to tag by hand.

### Download URLs (stable, always latest)

- PDF: `https://danielmeppiel.github.io/agentic-sdlc-handbook/The-Agentic-SDLC-Handbook.pdf`
- EPUB: `https://danielmeppiel.github.io/agentic-sdlc-handbook/The-Agentic-SDLC-Handbook.epub`
- Online: `https://danielmeppiel.github.io/agentic-sdlc-handbook/`

## Key files

| File | Purpose |
|------|---------|
| `_quarto.yml` | Book config — chapters, formats, footer CTA |
| `index.qmd` | Preface — "Why This Book Exists", author bio, download CTA |
| `download.qmd` | Download page with email signup form |
| `scripts/build-downloads.sh` | Optional local PDF/EPUB build |
| `.github/workflows/publish.yml` | CI — renders HTML, PDF and EPUB and deploys them to gh-pages |

## Content conventions

- Chapters are in `handbook/chNN-slug.qmd`
- Use Quarto callouts (`.callout-tip`, `.callout-note`) for CTAs
- CTAs link to `download.qmd` (relative: `../download.qmd` from chapters)
