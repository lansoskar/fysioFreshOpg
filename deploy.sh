#!/usr/bin/env sh

npm run build

cd dist

git init
git add -A
git commit -m 'Deploy'

git push -f git@github.com:<lansoskar>/<fysioFreshOpg>.git main:gh-pages

cd -