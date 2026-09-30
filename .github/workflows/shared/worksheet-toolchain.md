---
# Shared gh-aw component: the worksheet toolchain.
#
# No `on:` trigger, so this is a shared component, not a standalone workflow.
#
# Every worksheet stage needs Quarto (to render), Node (to run the layout
# gate) and Chromium (to screenshot the sheet). These steps are prepended to
# the agent job of any workflow that imports this file.
#
# This deliberately does NOT rely on copilot-setup-steps.yml. That file is for
# the Copilot *cloud agent* substrate and, per GitHub's own docs, "won't
# trigger unless it's present on your default branch". Installing the
# toolchain here instead means the whole factory runs from a feature branch,
# so it can be piloted before anything is merged to main.

description: Quarto, Node and Chromium for building and checking worksheets

steps:
  - name: Set up Quarto
    uses: quarto-dev/quarto-actions/setup@v2

  - name: Install the worksheet layout gate
    # ubuntu-latest ships Node 20+, so no setup-node action is needed. One
    # fewer third-party action in the supply chain for no loss of function.
    run: |
      set -euo pipefail
      node --version
      cd .github/skills/worksheet-build
      npm install --no-audit --no-fund
      npx playwright install --with-deps chromium

  - name: Show the toolchain
    run: |
      echo "quarto : $(quarto --version)"
      echo "node   : $(node --version)"
---

# Worksheet toolchain

Quarto, Node 20, the layout gate's dependencies and Chromium are installed and
ready before you start. You do not need to install them yourself.

Render and gate a worksheet with:

```bash
.github/skills/worksheet-build/scripts/render-worksheet.sh <ws_id>
```
