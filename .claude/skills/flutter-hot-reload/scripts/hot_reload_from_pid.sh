#!/usr/bin/env bash
set -euo pipefail

verbose=0
if [[ "${1:-}" == "--verbose" ]]; then
  verbose=1
fi

raw_pid_source="${FLUTTER_PID:-/tmp/flutter.pid}"
pid_source="$(printf '%s' "$raw_pid_source" | sed -E 's/^[[:space:]]+//; s/[[:space:]]+$//')"
if [[ -z "$pid_source" ]]; then
  pid_source="/tmp/flutter.pid"
fi
pid=""

if [[ $verbose -eq 1 && "$raw_pid_source" != "$pid_source" ]]; then
  echo "Trimmed FLUTTER_PID from '$raw_pid_source' to '$pid_source'"
fi

if [[ "$pid_source" =~ ^[0-9]+$ ]]; then
  pid="$pid_source"
  [[ $verbose -eq 1 ]] && echo "Using FLUTTER_PID as direct PID: $pid"
else
  if [[ ! -f "$pid_source" ]]; then
    echo "Hot reload failed: PID file not found at '$pid_source'." >&2
    exit 1
  fi
  pid="$(tr -dc '0-9' < "$pid_source")"
  if [[ -z "$pid" ]]; then
    echo "Hot reload failed: PID file '$pid_source' does not contain a PID." >&2
    exit 1
  fi
  [[ $verbose -eq 1 ]] && echo "Read Flutter PID '$pid' from '$pid_source'"
fi

if ! kill -0 "$pid" 2>/dev/null; then
  echo "Hot reload failed: process '$pid' is not running." >&2
  exit 1
fi

if ! kill -USR1 "$pid" 2>/dev/null; then
  echo "Hot reload failed: unable to send USR1 to process '$pid'." >&2
  exit 1
fi

[[ $verbose -eq 1 ]] && echo "Hot reload signal sent to PID $pid."
