# Contributing to AREDN Firmware Sync Script

Thanks for your interest in contributing! This project is maintained by volunteers at  
**Disaster Response Communications & Information Technology (DRCIT)** and is intended to be reused by other ham radio groups.

## How to Contribute

1. **Fork the repository**  
   - Click the *Fork* button on the top right of the repo.  
   - Clone your fork to your local system.  

2. **Create a new branch**  
   ```bash
   git checkout -b feature/my-improvement
   ```
   Use a descriptive branch name (e.g., `fix/logrotate-perms` or `docs/readme-typo`).

3. **Make your changes**  
   - Keep commits focused and meaningful.  
   - If you change script behavior, please also update the README if necessary.  

4. **Test your changes**  
   - Run the sync script manually.  
   - Confirm the log is written, `config.js` is patched, and `collect.py` regenerates JSON successfully.  

5. **Submit a Pull Request**  
   - Push your branch to your fork.  
   - Open a Pull Request (PR) back to the `main` branch of this repo.  
   - Describe what you changed and why.

## Coding Style

- Keep scripts **bash-compatible**.  
- Use `set -Eeuo pipefail` for safety where appropriate.  
- Use clear variable names (`ROOT`, `AFS`, `LOG`, etc.).  
- Keep user-facing docs in **Markdown** with code fenced in triple backticks.  

## Reporting Issues

If you find a bug or have a feature idea, please open an **Issue** on the repo with:  
- Steps to reproduce  
- What you expected  
- What actually happened  
- Your OS and shell (e.g., Ubuntu 22.04 / bash 5.x)

## License

By contributing, you agree that your contributions will be licensed under the same [MIT License](LICENSE) as the project.
