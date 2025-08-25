# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), 
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

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

