#!/usr/bin/env bash

set -e -u -o pipefail

CURRENT_VERSION=$(yq .inputs.version.default action.yml)

echo "Current version: $CURRENT_VERSION"

LATEST_VERSION=$(
  gh release list \
    --repo cryptaliagy/tomlq \
    --limit 1 \
    --exclude-pre-releases \
    --json name \
    --jq '.[0].name' | \
  cut -c5-
)

echo "Latest version: $LATEST_VERSION"

if [[ $CURRENT_VERSION == $LATEST_VERSION ]]; then
  echo "tq version has not changed. Exiting"
  exit
fi

git stash

FILES=$(git grep -l "$CURRENT_VERSION" -- ':!.github' ':!CHANGELOG.md' ':!version.txt')

if [[ $(uname) == 'Darwin' ]]; then
  echo "$FILES" | xargs sed -i '' -e "s/$CURRENT_VERSION/$LATEST_VERSION/g"
else
  echo "$FILES" | xargs sed -i -e "s/$CURRENT_VERSION/$LATEST_VERSION/g"
fi

npm run build

echo 'Creating PR...'
BRANCH="build/version-$LATEST_VERSION"
git checkout -b $BRANCH
git commit -am \
  "build(deps): bump tq from $CURRENT_VERSION to $LATEST_VERSION" \
  -m "Release-As: $(cat version.txt | awk -F. '/[0-9]+\./{$NF++;print}' OFS=.)" \
  -m "https://github.com/cryptaliagy/tomlq/releases/tag/$LATEST_VERSION"
git push --force origin $BRANCH
gh pr create --assignee remarkablemark --fill --reviewer remarkablemark

git stash pop || true
