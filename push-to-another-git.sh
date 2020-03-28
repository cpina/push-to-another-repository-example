#!/bin/sh

# Inspired from
#https://github.com/johno/actions-push-subdirectories/blob/master/entrypoint.sh#L10

FOLDER="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"

CLONE_DIR=output_clone

env

git clone --depth 1 "https://${$secrets.API_TOKEN_GITHUB}@github.com/$GITHUB_USERNAME/$NAME.git" "$CLONE_DIR" &> /dev/null

cd "$CLONE_DIR"
find . | grep -v ".git" | grep -v "^\.*$" | xargs rm -rf # delete all files (to handle deletions in monorepo)

cp -r "$FOLDER/." "$CLONE_DIR"

git add .
git commit --message "Update $NAME from $GITHUB_REPOSITORY"
git push origin master
echo "Done!"
