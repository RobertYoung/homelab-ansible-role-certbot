# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an Ansible role for automated SSL certificate management using Let's Encrypt certbot with AWS Route53 DNS validation. It runs certbot in Docker and uses systemd for scheduling renewals and triggering deploy hooks.

## Development Commands

### Linting
```bash
yamllint .                    # Lint all YAML files
ansible-lint                  # Lint Ansible code (currently disabled in CI)
```

### Pre-commit Hooks
```bash
pre-commit install            # Install hooks
pre-commit run --all-files    # Run all hooks manually
```

### Tool Management
Uses `mise` for tool versions (Ansible 13, pipx 1.8). Run `mise install` to set up.

## Architecture

The role creates a systemd-based certificate renewal system:

1. **Certbot Container** (`docker-compose.yml.j2`) - Runs `certbot/dns-route53` image for DNS-01 challenge validation
2. **Systemd Timer** (`certbot.timer.j2`) - Triggers daily certificate renewal checks at midnight
3. **Systemd Service** (`certbot.service.j2`) - Runs `docker compose run` to execute certbot
4. **Deploy Hook System** (optional):
   - `certbot-deploy-hook.path.j2` - Watches `fullchain.pem` for changes
   - `certbot-deploy-hook.service.j2` - Executes custom deploy hook script when certificate changes

## Required Variables

- `certbot_domain` - Domain to obtain certificate for
- `certbot_aws_access_key` - AWS access key for Route53
- `certbot_aws_secret_access_key` - AWS secret key for Route53

## Optional Variables

- `certbot_deploy_hook_script` - Path to custom deploy hook script (enables the path watcher systemd units)

## YAML Style

Line length max 120, truthy values must be "true"/"false"/"yes"/"no", 1 space minimum after comments.
