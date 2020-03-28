#!/bin/sh -e

# Inspired from
#https://github.com/johno/actions-push-subdirectories/blob/master/entrypoint.sh#L10

FOLDER="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"

CLONE_DIR=output_clone

apt-get update && apt-get install git
apk add --no-cache git

git clone --depth 1 "https://$API_TOKEN_GITHUB@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git" "$CLONE_DIR"

ls -l

find "$CLONE_DIR" | grep -v ".git" | grep -v "^\.*$" | xargs rm -rf # delete all files (to handle deletions in monorepo)

cp -r "$FOLDER/." "$CLONE_DIR"

cd "$CLONE_DIR"

git add .
git commit --message "Update $NAME from $GITHUB_REPOSITORY"
git push origin master

cd ..
echo "Done!"

