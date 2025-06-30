# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Homebrew tap for the `spotinfo` CLI tool - a command-line utility for exploring AWS EC2 Spot instances with comprehensive pricing analysis and interruption data. The repository contains a Homebrew formula that distributes pre-built binaries from the upstream GitHub releases.

## Key Files

- `Formula/spotinfo.rb` - Homebrew formula definition with platform-specific binary URLs and SHA256 checksums
- `update-formula.sh` - Script to update the formula to the latest upstream release
- `.github/workflows/auto-update.yaml` - GitHub Action for automatic weekly formula updates

## Development Commands

### Formula Updates

```bash
# Update to latest release (recommended)
./update-formula.sh

# Update to specific version
./update-formula.sh 2.1.0
```

### Testing

```bash
# Test formula installation from source
brew install --build-from-source Formula/spotinfo.rb

# Run formula tests
brew test spotinfo

# Audit formula for issues (use formula name, not path)
brew audit --strict spotinfo

# Uninstall for testing
brew uninstall spotinfo
```

### Formula Maintenance

The formula supports both manual and automatic updates:

- **Manual**: Run `./update-formula.sh` when needed
- **Automatic**: GitHub Action runs weekly on Mondays at 9 AM UTC

## Architecture

This is a binary distribution tap that:

1. Downloads pre-built binaries from `alexei-led/spotinfo` GitHub releases
2. Supports multiple platforms: macOS (Intel/ARM), Linux (Intel/ARM)
3. Uses SHA256 checksums for security verification
4. Uses platform-specific binary selection in the install method
5. Installs the binary as `spotinfo` in the user's PATH

The update process fetches the latest release, downloads all platform binaries, calculates checksums, and updates the formula file with new version and SHA256 values.

## Formula Best Practices Implemented

- Platform detection using `on_macos`/`on_linux` blocks
- Hardware architecture detection with `Hardware::CPU.arm?`
- Specific binary selection instead of glob patterns
- Comprehensive test suite with multiple assertions
- Proper description and licensing information
- SHA256 checksum verification for all platforms

## Commit Workflow

After updating the formula:

1. Review changes: `git diff Formula/spotinfo.rb`
2. Test locally: `brew install --build-from-source Formula/spotinfo.rb`
3. Run tests: `brew test spotinfo`
4. Commit: `git add Formula/spotinfo.rb && git commit -m "Update spotinfo to VERSION"`
5. Push: `git push`

## Current Status

- **Version**: 2.0.0 (includes MCP server support)
- **Platforms**: All supported (macOS Intel/ARM, Linux Intel/ARM)
- **Formula Quality**: Passes all tests and follows Homebrew best practices
- **Auto-updates**: Enabled via GitHub Actions (weekly on Mondays)