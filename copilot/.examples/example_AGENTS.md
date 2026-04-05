# Workspace AI Agent Guidelines

This file provides the baseline instructions for all AI coding agents operating within this workspace or monorepo subfolder.

## Technology Stack & Architecture
- This project uses React on the frontend and Node.js/Express on the backend.
- We strictly follow Domain-Driven Design (DDD) principles. Do not mix infrastructure code with domain logic.
- All database queries must use the Prisma ORM. Do not write raw SQL unless explicitly requested.

## Security & Auth
- All API endpoints must validate user authorization via JWT tokens.
- Never log Personally Identifiable Information (PII) or secrets.

## Global Directives
<!-- @import _core/1_governance/execution_safety.md -->
<!-- @import _core/3_engineering/code_standards.md -->