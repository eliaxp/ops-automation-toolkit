# 🚀 Ops Automation Toolkit

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/eliaxp/ops-automation-toolkit)](https://github.com/eliaxp/ops-automation-toolkit)

A collection of DevOps automation scripts for common infrastructure, deployment, and monitoring tasks.

## What's this?

Handy bash scripts I've put together over time to automate the boring stuff. Nothing fancy, just scripts that work and save time.

## What's included

- Deployment scripts
- Backup automation
- System health checks
- Basic utilities

## Requirements

- Bash 4.0+
- Standard Linux tools (curl, tar, etc.)

## Quick start

```bash
git clone https://github.com/eliaxp/ops-automation-toolkit.git
cd ops-automation-toolkit
chmod +x scripts/*.sh
```

## Usage

### Backup a directory
```bash
./scripts/backup.sh /path/to/backup /backup/destination
```

### Check system health
```bash
./scripts/health-check.sh
```

### Deploy to an environment
```bash
./scripts/deploy.sh staging
```

## Project structure

```
ops-automation-toolkit/
├── README.md
├── LICENSE
├── scripts/
│   ├── backup.sh
│   ├── health-check.sh
│   ├── deploy.sh
│   └── utils.sh
├── config/
│   └── config.example
└── docs/
```

## Contributing

Feel free to submit PRs or open issues. Just keep it simple and useful.

1. Fork it
2. Create a branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add something useful'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

MIT License - see [LICENSE](LICENSE) for details.

## Author

**Elias Perez**

- GitHub: [@eliaxp](https://github.com/eliaxp)

---

⭐ If you find this useful, a star would be awesome!


