#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
STATE_DIR="${STATE_DIR:-${REPO_DIR}/.hermes-task-loop}"
OUT_FILE="${1:-${STATE_DIR}/issues.json}"
TOKEN_FILE="${TOKEN_FILE:-${REPO_DIR}/GITHUB_TOKEN}"
HERMES_ENV_FILE="${HERMES_ENV_FILE:-${HERMES_HOME:-$HOME/.hermes}/.env}"

mkdir -p "$(dirname "${OUT_FILE}")"

if ! command -v gh >/dev/null 2>&1; then
  echo "GitHub CLI not found. Install gh." >&2
  exit 1
fi

if [[ -z "${GH_TOKEN:-}" ]]; then
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    GH_TOKEN="${GITHUB_TOKEN}"
  elif [[ -s "${TOKEN_FILE}" ]]; then
    GH_TOKEN="$(tr -d '\r\n' <"${TOKEN_FILE}")"
  elif [[ -s "${HERMES_ENV_FILE}" ]]; then
    GH_TOKEN="$(python3 - "${HERMES_ENV_FILE}" <<'PY'
import sys
from pathlib import Path
for line in Path(sys.argv[1]).read_text().splitlines():
    line = line.strip()
    if not line or line.startswith('#') or '=' not in line:
        continue
    key, value = line.split('=', 1)
    if key.strip() == 'GITHUB_TOKEN':
        print(value.strip().strip('"').strip("'"))
        break
PY
)"
  fi
fi

if [[ -z "${GH_TOKEN:-}" ]]; then
  echo "Missing GitHub token. Set GH_TOKEN/GITHUB_TOKEN, ${HERMES_ENV_FILE}, or ${TOKEN_FILE}." >&2
  exit 1
fi
export GH_TOKEN

tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT

labels=(inbox plan open pending)
for label in "${labels[@]}"; do
  gh issue list \
    --repo ChrisMarxDev/custom_bingo \
    --state open \
    --label "${label}" \
    --limit 100 \
    --json number,title,body,labels,url,updatedAt,createdAt \
    >"${tmp_dir}/${label}.json"
done

python3 - "$OUT_FILE" "${tmp_dir}" <<'PY'
import json
import sys
from pathlib import Path

out_file = Path(sys.argv[1])
tmp_dir = Path(sys.argv[2])
labels = ("inbox", "plan", "open", "pending")

by_number = {}
for label in labels:
    issues = json.loads((tmp_dir / f"{label}.json").read_text())
    for issue in issues:
        number = issue["number"]
        entry = by_number.setdefault(number, issue)
        entry_labels = {item["name"] for item in entry.get("labels", [])}
        entry["workflowLabels"] = sorted(entry_labels.intersection(labels))

actionable = [
    issue for issue in by_number.values()
    if {"inbox", "plan", "open"}.intersection(issue.get("workflowLabels", []))
]

payload = {
    "repo": "ChrisMarxDev/custom_bingo",
    "counts": {
        "inbox": sum("inbox" in issue.get("workflowLabels", []) for issue in by_number.values()),
        "plan": sum("plan" in issue.get("workflowLabels", []) for issue in by_number.values()),
        "open": sum("open" in issue.get("workflowLabels", []) for issue in by_number.values()),
        "pending": sum("pending" in issue.get("workflowLabels", []) for issue in by_number.values()),
        "actionable": len(actionable),
    },
    "issues": sorted(by_number.values(), key=lambda item: item["number"]),
}

out_file.write_text(json.dumps(payload, indent=2) + "\n")
print(json.dumps(payload["counts"], sort_keys=True))
PY
