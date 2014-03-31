current_branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
rm -rf `find . -regex .+\.orig`
echo "Pull Branch Actual: $current_branch"
echo "Pull 1/2 git pull origin $current_branch ..."
git pull origin $current_branch
echo "Pull 2/2 git pull --force ..."
git pull --force
echo "Pull terminado!"
