#!/bin/bash

# copy the CNAME file into the release folder so that it ends up in the gh-pages branch
cp CNAME release
# check out a detached head either from the environment var $GIT_COMMIT (which Jenkins
# has), or using the last commit against HEAD (for local/non-Jenkins dev)
git checkout ${GIT_COMMIT:=$(git rev-parse --short HEAD)} #detached head
# add files from the newly created /release folder
git add release
# check in the changes
git commit -m "Generated from $GIT_COMMIT"
# create a new branch named 'gh-pages-$GIT_COMMIT' with only the code from the /release folder
git subtree split --prefix release -b gh-pages-$GIT_COMMIT
# add github-mozmar-robot remote if it doesn't exist
if [[ ! $(git remote) =~ github-mozmar-robot ]]; then
    git remote add github-mozmar-robot github-mozmar-robot:mozilla/awebpodcast
fi
# push our bespoke branch to the gh-pages branch
git push -f github-mozmar-robot gh-pages-$GIT_COMMIT:gh-pages
