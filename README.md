# Homebrew spotinfo Tap

Homebrew tap for [spotinfo](https://github.com/alexei-led/spotinfo) 🍺

> The `spotinfo` is a command-line tool that helps you explore AWS EC2 Spot instances with pricing analysis and interruption data. It provides comprehensive filtering capabilities and multiple output formats to help you make informed decisions about spot instance usage.

## Install

```sh
brew tap alexei-led/spotinfo
brew install spotinfo
```

## Maintenance

This tap provides two options for keeping the formula up to date:

### Option 1: Manual Updates (Recommended)

Run the update script when you want to update to the latest release:

```bash
./update-formula.sh
```

The script will:
- Fetch the latest release version
- Download binaries and calculate SHA256 checksums
- Update the formula file
- Provide next steps for testing and committing

### Option 2: Automatic Updates (Optional)

A GitHub Action runs weekly to check for new releases and automatically updates the formula.

- **Schedule**: Weekly on Mondays at 9 AM UTC
- **Manual trigger**: Available via GitHub Actions tab
- **What it does**: Checks for new releases, updates formula, commits changes

To disable automatic updates, simply delete `.github/workflows/auto-update.yaml`.

## Testing

Before committing formula changes:

```bash
# Test the formula
brew install --build-from-source Formula/spotinfo.rb

# Audit for issues
brew audit --strict Formula/spotinfo.rb
```

## Formula Details

The formula uses pre-built binaries from GitHub releases for faster installation:
- **Platforms**: macOS (Intel/ARM), Linux (Intel/ARM)  
- **No build dependencies**: Go, make, wget not required for installation
- **Fast installation**: Downloads binary directly, no compilation needed
- **Version**: Currently tracks version 2.0.0 with Model Context Protocol (MCP) server support
- **Architecture detection**: Automatically selects the correct binary for your platform
