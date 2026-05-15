# Validation

Run:

```bash
test -f README.md
test -f PUBLIC_BOUNDARY.md
test -f scripts/validate-public-boundary.sh
bash scripts/validate-public-boundary.sh
rg -n "planned|scaffolded|published|released|private/not-public|live apps|active customers|deployed software|released software|production endpoints|credentials|customer data|private source|unreleased product|production secrets|validation|review" .
git diff --check
git status --short
git remote -v
```

