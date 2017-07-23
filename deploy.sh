#!/bin/bash
# commit message as parameter

cd ~/Github/site-hugo/

echo "deploying to github pages"

# Build Project
hugo

cd public

echo "adding all changes to git"
git add -A

msg="rebuilding site `date`"
if [ $# -eq 1 ]
    then msg="$1"
fi
git commit -m "$msg"

git push origin master

cd ..

