# 📖 Documentation Index & Navigation Guide

## For Different Audiences

### 👨‍💻 Developers Starting Fresh
**Start here**: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) (5 min read)
Then: [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) (10 min read)

### 🏗️ Architects & Tech Leads
**Start here**: [ARCHITECTURE.md](./ARCHITECTURE.md) (15 min read)
Then: [SETUP_COMPLETE.md](./SETUP_COMPLETE.md) for recent changes (5 min read)

### 🤖 AI Coding Agents
**Start here**: [.github/copilot-instructions.md](./.github/copilot-instructions.md) (read all, ~20 lines)
Reference: [ARCHITECTURE.md](./ARCHITECTURE.md) for patterns & decisions

### 📦 DevOps / Deployment
**Start here**: [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → "Production Deployment" section
Reference: [ARCHITECTURE.md](./ARCHITECTURE.md) → "Deployment Pipeline"

### 🧪 QA / Testing Engineers
**Start here**: [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → "Testing" section
Reference: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) → "Troubleshooting"

---

## Document Overview

| Document | Audience | Length | Key Topics |
|----------|----------|--------|-----------|
| **README.md** | Everyone | 2 min | Quick start, tech stack, links |
| **QUICK_REFERENCE.md** | Developers | 5 min | Common commands, troubleshooting |
| **DEVELOPMENT_SETUP.md** | Developers, DevOps | 15 min | Complete setup, step-by-step, detailed troubleshooting |
| **ARCHITECTURE.md** | Tech leads, Developers | 20 min | Design decisions, patterns, structure, workflows |
| **SETUP_COMPLETE.md** | Team leads | 10 min | Summary of changes, what was fixed, next steps |
| **FIXES_SUMMARY.md** | Tech leads, Developers | 5 min | What was fixed and why |
| **.github/copilot-instructions.md** | AI agents | 3 min | Coding guidelines, patterns, conventions |

---

## Quick Navigation by Task

### "I want to start development"
1. Read: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) - Most common commands
2. Run: Commands in "🎯 Most Common Commands" section
3. Stuck? → [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → Troubleshooting

### "I'm deploying to production"
1. Read: [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → "Production Deployment"
2. Set API key: See Configuration section
3. Run deployment commands
4. Verify: Check production CI/CD pipeline

### "I'm adding a new feature"
1. Check: [ARCHITECTURE.md](./ARCHITECTURE.md) → Project-Specific Conventions
2. For Flutter: Feature-first structure in `apps/flutter_app/lib/features/`
3. For Functions: Single file per function in `apps/firebase_functions/src/callable/`
4. Build & test locally before committing

### "Something's broken"
1. Check: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) → Troubleshooting
2. Not there? → [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → Troubleshooting
3. Still stuck? → Check [FIXES_SUMMARY.md](./FIXES_SUMMARY.md) for recent changes

### "I need to understand the architecture"
1. Read: [ARCHITECTURE.md](./ARCHITECTURE.md) - Full deep dive
2. Visual: See "Architecture Diagram" section
3. Reference: [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) → Architecture Diagram

### "I'm reviewing the recent changes"
1. Read: [FIXES_SUMMARY.md](./FIXES_SUMMARY.md) - What changed and why
2. Details: [SETUP_COMPLETE.md](./SETUP_COMPLETE.md) - Complete summary
3. Verify: Run verification script in [SETUP_COMPLETE.md](./SETUP_COMPLETE.md)

---

## Document Relationships

```
                        README.md (Overview)
                             ↓
                    ┌────────┴────────┐
                    ↓                  ↓
            QUICK_REFERENCE        ARCHITECTURE
            (Command Ref)          (Design Deep Dive)
                    ↓                  ↓
                    └────────┬────────┘
                             ↓
                    DEVELOPMENT_SETUP
                   (Implementation Guide)
                             ↓
                      SETUP_COMPLETE
                   (Change Summary)
```

---

## File Change Matrix

### If You Modified...
| File | Read This | Reason |
|------|-----------|--------|
| Functions code (TypeScript) | [ARCHITECTURE.md](./ARCHITECTURE.md) → Project-Specific Conventions | Patterns & guidelines |
| Flutter code (Dart) | [ARCHITECTURE.md](./ARCHITECTURE.md) → Flutter conventions | Patterns & best practices |
| Dependencies | [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → "Dependency & Environment Issues" | Compatibility matrix |
| firebase.json | [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → Step 1 | Configuration format |
| melos.yaml | [ARCHITECTURE.md](./ARCHITECTURE.md) → Monorepo Structure | Workspace management |

---

## Documentation Maintenance

### Last Updated
- **Date**: January 13, 2026
- **Version**: 1.0 (Initial complete documentation)
- **Status**: ✅ All files verified and linked

### How to Keep Docs Updated
1. When fixing a bug: Update [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) troubleshooting section
2. When changing architecture: Update [ARCHITECTURE.md](./ARCHITECTURE.md)
3. When adding setup steps: Update [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md)
4. When updating conventions: Update **.github/copilot-instructions.md**

### Documentation CI/CD
- All docs should be markdown (.md)
- Links should use relative paths: `[name](./file.md)`
- Keep docs in sync with code changes
- Review before merging to main branch

---

## Quick Links Reference

### Configuration Files
- [firebase.json](./firebase.json) - Emulator & Functions config
- [firestore.rules](./firestore.rules) - Security rules
- [bazi_fengshui_app/melos.yaml](./bazi_fengshui_app/melos.yaml) - Workspace config

### Source Code
- [Flutter App](./bazi_fengshui_app/apps/flutter_app/) - Main application
- [Firebase Functions](./bazi_fengshui_app/apps/firebase_functions/) - Cloud Functions
- [Shared Types](./bazi_fengshui_app/packages/shared_types/) - Cross-platform types

### CI/CD
- [.github/workflows/](./.github/workflows/) - GitHub Actions

---

## Checklists

### New Team Member Onboarding
- [ ] Read [README.md](./README.md) (2 min)
- [ ] Read [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) (5 min)
- [ ] Run [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) steps (30 min)
- [ ] Verify setup with provided script (5 min)
- [ ] Run Firebase emulator locally (10 min)
- [ ] Run Flutter app & test (10 min)
- [ ] Make first code change & build (15 min)
- [ ] Understand [ARCHITECTURE.md](./ARCHITECTURE.md) patterns (20 min)
**Total**: ~90 minutes

### Code Review Checklist
- [ ] Changes follow [ARCHITECTURE.md](./ARCHITECTURE.md) conventions
- [ ] No [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) troubleshooting issues introduced
- [ ] Documentation updated (if applicable)
- [ ] Tests pass locally (see [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md))
- [ ] Deployment steps verified

---

## Support & Help

**Problem**: Can't find what you need  
**Solution**: 
1. Use Ctrl+F to search current docs
2. Check document index above
3. Search [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md) → Troubleshooting

**Problem**: Conflicting information in docs  
**Solution**: 
1. Check Last Updated date → use newest docs
2. Report issue to maintainer (raywong435)
3. Reference [FIXES_SUMMARY.md](./FIXES_SUMMARY.md) for recent changes

---

## Document Statistics

```
Total Documentation:
├── README.md                      ~200 lines
├── QUICK_REFERENCE.md            ~150 lines
├── DEVELOPMENT_SETUP.md          ~250 lines
├── ARCHITECTURE.md               ~400 lines
├── SETUP_COMPLETE.md             ~300 lines
├── FIXES_SUMMARY.md              ~100 lines
├── .github/copilot-instructions.md ~150 lines
└── This file (Documentation Index) ~300 lines
    ──────────────────────────────────────
    Total:                        ~1,850 lines
```

---

**Start Here**: [README.md](./README.md) → [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) → [DEVELOPMENT_SETUP.md](./DEVELOPMENT_SETUP.md)

**Questions?** Check document overview above or search the specific guide.
