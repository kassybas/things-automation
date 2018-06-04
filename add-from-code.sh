#!/usr/bin/env bash

# This supposed to create a task for a file grepping the // TODO: entries

set -eu

readonly filename="${1?Please provide a filename}"
readonly repo="$(basename `git rev-parse --show-toplevel`)"
readonly branch="$(git rev-parse --abbrev-ref HEAD)"
readonly path="$(pwd)"
readonly notes="${branch} (repo: ${repo})"

# Get todos from file
todos="$(grep -n -iE "(\Wtodo\W|\Wtodob\W)" ${filename} | sed 's/  */ /g;s/[\/#].*[tT][Oo][Dd][Oo][b]*[:]*//g')"
checklist=""

while read p; do
    checklist="${checklist}
${p}"
done <<< ${todos}

readonly tag="code-snip"

#Create todo
open "things:///add?title=${filename}&notes=${notes}&checklist-items=${checklist}&list=${repo}&tags=${tag}&show-quick-entry=true&reveal=false"
