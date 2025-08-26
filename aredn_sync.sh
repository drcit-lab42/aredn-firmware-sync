#!/usr/bin/env bash
set -Eeuo pipefail

# ================================
# DRCIT Firmware Mirror Sync
# ================================

# --- Variables techs should edit ---
ROOT="<path to root folder>/aredn"   # main repo root
AFS="$ROOT/afs"                                    # site files live under here
LOG="$HOME/.local/logs/aredn.log"                  # log path
UPSTREAM="downloads.arednmesh.org::aredn_firmware" # rsync source
NEW_URL="http://n2drc-<server_region>.local.mesh/"             # local mesh URL to inject

# --- Derived paths (do not edit) ---
CONFIG_JS="$AFS/www/config.js"
COLLECT_PY="$AFS/misc/collect.py"

# --- Logging helper ---
mkdir -p "$(dirname "$LOG")"
log() { printf '%s %s\n' "$(date '+%F %T')" "$*" | tee -a "$LOG"; }

# ================================
# Main Script
# ================================

log "=== run start ==="

# 1) Sync firmware
log "rsync from $UPSTREAM to $ROOT/"
rsync -rv --delete --size-only "$UPSTREAM" "$ROOT/" >>"$LOG" 2>&1
log "rsync complete."

# 2) Patch config.js
if [[ -f "$CONFIG_JS" ]]; then
  log "CONFIG_JS before patch:"
  grep -n 'image_url' "$CONFIG_JS" | tee -a "$LOG" || true

  cp -a "$CONFIG_JS" "${CONFIG_JS}.bak.$(date +%F-%H%M%S)"
  LC_ALL=C sed -i -E \
    's~(^[[:space:]]*image_url:[[:space:]]*")[^"]*(".*)~\1'"$NEW_URL"'\2~' \
    "$CONFIG_JS"

  log "CONFIG_JS after patch:"
  grep -n 'image_url' "$CONFIG_JS" | tee -a "$LOG" || true
else
  log "ERROR: config.js not found at $CONFIG_JS"
fi

# 3) run collect.py
if [ -x "$AFS/misc/collect.py" ]; then
  (
    cd "$ROOT" || { log "ERROR: ROOT dir not found: $ROOT"; exit 1; }
    # make sure it’s executable (first-run safety)
    chmod +x "$AFS/misc/collect.py" 2>/dev/null || true
    log "collect: cwd=$ROOT  using $(head -1 ./afs/misc/collect.py)"
    # suppress noisy SyntaxWarning; write all output to the log
    PYTHONWARNINGS=ignore::SyntaxWarning \
    ./afs/misc/collect.py . ./afs/www/ >>"$LOG" 2>&1
  )
  rc=$?
  if [ $rc -ne 0 ]; then
    log "ERROR: collect.py exited with status $rc"
    exit $rc
  fi
  log "collect.py complete"
else
  log "WARNING: collect.py not found or not executable at $AFS/misc/collect.py"
fi

log "=== run finished ==="
