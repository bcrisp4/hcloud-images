# HCloud Images

This repository contains custom images for [Hetzner Cloud (HCloud)](https://docs.hetzner.com/cloud/)
built using [Packer](https://www.packer.io/).

## CI/CD

This project uses GitHub Actions to automatically build and validate Packer configurations.

### Workflows

- **Packer Build** (`.github/workflows/packer.yml`):
  - **Validate**: Runs on all PRs and pushes - validates Packer configuration and formatting
  - **Build**: Runs on pushes to `main` branch or manual triggers - builds the actual image

### Manual Builds

You can manually trigger a build from the Actions tab:

1. Go to the "Actions" tab in your repository
2. Select "Packer Build" workflow
3. Click "Run workflow"
4. Optionally specify a Talos version (e.g., `v1.7.0`)
5. Click "Run workflow"
