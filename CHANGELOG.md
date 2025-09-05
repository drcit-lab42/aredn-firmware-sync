# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), 
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---
## [v1.1.0] - 2025-09-05
### Fixed
- Resolved an issue where `collect.py` was overwriting `afs/www/config.js` after firmware sync.
  - Added automatic backup of `config.js` before running `collect.py`.
  - After `collect.py` completes, `config.js` is restored from backup.
  - This ensures the latest firmware versions remain publishable and prevents accidental corruption of the patched config.

### Notes
- This is a **temporary workaround** until upstream AREDN addresses [ticketed bug](https://github.com/drcit-lab42/aredn-firmware-sync/issues/5).
- Since all files are refreshed on each rsync, this solution is safe and has minimal overhead.


## [v1.0.0-rc.2] - 2025-08-26
### Fixed
- Corrected `collect.py` execution to run from `$ROOT` instead of hard-coded path.
- Ensured firmware indexes are regenerated properly when the sync script runs.


## [v1.0.0-rc.1] - 2025-08-25
### Added
- First release candidate of the AREDN Firmware Sync Script.
- Automated sync from upstream AREDN firmware repository using rsync.
- Local patching of `config.js` to mesh-local firmware URL.
- Automatic JSON regeneration via `collect.py`.
- Logging to `~/.local/logs/aredn.log` with before/after patch details.
- Log rotation support (sample config provided in README).
- Easy install via `install -m 755` into `~/.local/bin/`.

### Notes
- This is a **release candidate**. Functionality tested locally, may require adjustments in other environments.
- Feedback is encouraged before the final **v1.0.0** release.
