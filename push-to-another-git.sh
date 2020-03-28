#!/bin/sh -ex

# Inspired from
#https://github.com/johno/actions-push-subdirectories/blob/master/entrypoint.sh#L10

FOLDER="$1"
GITHUB_USERNAME="$2"
GITHUB_REPO="$3"

CLONE_DIR=output_clone

apt-get update && apt-get install git
apk add --no-cache git

git config --global user.email "carles@pina.cat"
git config --global user.name "$GITHUB_USERNAME"

git clone "https://$API_TOKEN_GITHUB@github.com/$GITHUB_USERNAME/$GITHUB_REPO.git" "$CLONE_DIR"

ls -l

cd "$CLONE_DIR"
# find needs to be in the git repository directory
find . | grep -v ".git" | grep -v "^\.*$" | xargs rm -rf # delete all files (to handle deletions)

cp -r "../$FOLDER"/* .

echo "After cd $CLONE_DIR"

ls -la

git add .
git commit --message "Update from $GITHUB_REPOSITORY"
git push origin master

cd ..
echo "Done!"

