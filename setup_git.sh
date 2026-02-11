#!/bin/bash
git init
git add .
git commit -m "Initial commit: Flutter Riverpod Clean Architecture Template"
git branch -M main
git remote add origin https://github.com/DevDabbagh/Flutter-Riverpod-Clean-Architecture-Template.git
git push -u origin main
echo "Git repository initialized and pushed!"
