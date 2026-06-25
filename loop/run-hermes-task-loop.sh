#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_NAME="$(basename "${REPO_DIR}" | tr -c 'A-Za-z0-9_-' '-')"

HERMES_BIN="${HERMES_BIN:-hermes}"
LOCK_FILE="${LOCK_FILE:-/tmp/${REPO_NAME}-hermes-task-loop.lock}"
STATE_DIR="${STATE_DIR:-${REPO_DIR}/.hermes-task-loop}"
LOG_DIR="${LOG_DIR:-${STATE_DIR}/logs}"
ISSUES_FILE="${ISSUES_FILE:-${STATE_DIR}/issues.json}"
PROMPT_FILE="${PROMPT_FILE:-${STATE_DIR}/task-prompt.txt}"
TASK_SKILL_FILE="${TASK_SKILL_FILE:-${REPO_DIR}/loop/skills/task-workflow/SKILL.md}"

mkdir -p "${LOG_DIR}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
log_file="${LOG_DIR}/${timestamp}-task-prefetch.log"

if ! command -v flock >/dev/null 2>&1; then
  echo "flock is required. Install util-linux on the server." >&2
  exit 1
fi

if ! command -v "${HERMES_BIN}" >/dev/null 2>&1; then
  echo "Hermes CLI not found. Set HERMES_BIN or install hermes." >&2
  exit 1
fi

if [[ ! -f "${TASK_SKILL_FILE}" ]]; then
  echo "Missing bundled task workflow skill: ${TASK_SKILL_FILE}" >&2
  exit 1
fi

(
  flock -n 9 || exit 0

  {
    echo "=== hermes task loop prefetch ${timestamp} ==="
    echo "repo: ${REPO_DIR}"
    echo "hermes: $(command -v "${HERMES_BIN}")"
    echo
    bash "${SCRIPT_DIR}/fetch-issues.sh" "${ISSUES_FILE}"
  } >"${log_file}" 2>&1

  actionable_count="$(
    python3 - "${ISSUES_FILE}" <<'PY'
import json
import sys
from pathlib import Path

payload = json.loads(Path(sys.argv[1]).read_text())
print(payload.get("counts", {}).get("actionable", 0))
PY
  )"

  if [[ "${actionable_count}" == "0" ]]; then
    exit 0
  fi

  cat >"${PROMPT_FILE}" <<PROMPT
Run the GitHub issue task workflow for the custom_bingo repo.

First read and follow the local workflow skill at:
${TASK_SKILL_FILE}

The deterministic prefetch found ${actionable_count} actionable issue(s). Start from this prefetched snapshot instead of spending tokens discovering whether work exists:
${ISSUES_FILE}

Process GitHub Issues according to the task workflow:
- sort inbox issues first
- complete plan issues by posting technical plans, then leave them open as pending for user review
- implement open issues one at a time
- re-fetch issue state after each state-changing action

Use GH_TOKEN/GITHUB_TOKEN from /root/.hermes/.env for GitHub CLI authentication. Do not print the token.
Commit directly to main for implemented open issues, comment with the commit hash and validation result, and close completed issues.
Stop only when there are no actionable inbox, plan, or open issues left, the user-facing workflow labels all represent pending/blocked work, or a blocker prevents responsible progress.
PROMPT

  if [[ "${HERMES_LOOP_DRY_RUN:-0}" == "1" ]]; then
    echo "DRY RUN: Hermes task loop would process ${actionable_count} actionable issue(s)."
    echo "Snapshot: ${ISSUES_FILE}"
    echo "Prompt: ${PROMPT_FILE}"
    exit 0
  fi

  echo "Hermes task loop found ${actionable_count} actionable issue(s)."
  "${HERMES_BIN}" --yolo chat -Q -t terminal,file,skills -q "$(cat "${PROMPT_FILE}")"
) 9>"${LOCK_FILE}"
