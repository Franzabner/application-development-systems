#!/usr/bin/env bash
set -u

missing=0

required_files=(
  "AGENTS.md"
  "README.md"
  "STATUS.md"
  "PUBLIC_BOUNDARY.md"
  "CLAIMS.md"
  "VALIDATION.md"
  "ARTIFACT_REGISTER.md"
  "REVIEW_LOG.md"
  "package.json"
  "tsconfig.json"
  "next.config.mjs"
  "tailwind.config.ts"
  "postcss.config.mjs"
  "app-architecture/README.md"
  "app-architecture/public-safe-nextjs-architecture.md"
  "component-patterns/README.md"
  "component-patterns/shadcn-tailwind-component-boundary.md"
  "product-boundaries/README.md"
  "product-boundaries/product-client-app-boundary.md"
  "ai-assisted-delivery/README.md"
  "ai-assisted-delivery/ai-assisted-review-workflow.md"
  "review-workflows/README.md"
  "review-workflows/pull-request-review-checklist.md"
  "deployment-assumptions/README.md"
  "deployment-assumptions/vercel-public-safe-assumptions.md"
  "deployment-assumptions/supabase-stripe-boundary-notes.md"
  "validation/README.md"
  "validation/lint-typecheck-build-validation.md"
  "ownership-separation/README.md"
  "ownership-separation/app-ownership-boundary.md"
  "diagrams/README.md"
  "diagrams/app-delivery-review-flow.mmd"
  "scripts/validate-public-boundary.sh"
  "scripts/run-static-validation-placeholder.sh"
  "templates/app-architecture-decision-template.md"
  "templates/app-review-record-template.md"
)

for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    printf "PASS %s\n" "$file"
  else
    printf "FAIL %s\n" "$file"
    missing=$((missing + 1))
  fi
done

required_terms=(
  "planned"
  "scaffolded"
  "published"
  "released"
  "private/not-public"
  "live apps"
  "active customers"
  "deployed software"
  "released software"
  "production endpoints"
  "credentials"
  "customer data"
  "private source"
  "unreleased product"
  "production secrets"
  "validation"
  "review"
)

for term in "${required_terms[@]}"; do
  if rg -q "$term" .; then
    printf "PASS term: %s\n" "$term"
  else
    printf "FAIL term: %s\n" "$term"
    missing=$((missing + 1))
  fi
done

blocked_files="$(find . -path ./.git -prune -o \( -iname '*.key' -o -iname '*.pem' -o -iname '*.env' -o -iname '*.log' -o -iname '*.sqlite' \) -print)"
if [ -z "$blocked_files" ]; then
  printf "PASS blocked artifact scan\n"
else
  printf "FAIL blocked artifact scan\n%s\n" "$blocked_files"
  missing=$((missing + 1))
fi

if [ "$missing" -eq 0 ]; then
  printf "Result: PASS - application development public boundary scaffold is complete.\n"
else
  printf "Result: FAIL - %s required checks failed.\n" "$missing"
fi

exit "$missing"

