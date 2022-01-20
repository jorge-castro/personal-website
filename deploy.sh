#!/bin/sh

# If a command fails then the deploy stops.
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t sam # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go to public directory.
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Return to the project root.
cd ../

# Update submodule reference.
git add public
git commit -m "Update submodule reference"

# Push the source project and the public submodule together.
git push -u origin master --recurse-submodules=on-demand

#Built with help from https://dev.to/aormsby/how-to-set-up-a-hugo-site-on-github-pages-with-git-submodules-106p

