#!/usr/bin/env bash

### 
## FOR MORE INFORMATION:
## https://stackoverflow.com/questions/4713088/how-to-use-git-bisect
###


#####
## ACTIONS:
## ACTION #1 - Navigate to the project folder
## ACTION #2 - git bisect start
## ACTION #3 - Bisect automatically all the way to the first bad or last good rev
## ACTION #4 - Show the first bad commit
## ACTION #5 - End the bisect operation and checkout to last visited branch again
#####

# ---------------------------------------------------------------------------------------------------------------- #

# -- START: LOAD ENVIRONMENT VARIABLES --

echo "Clearing relevant environment variables\n";

export CURRENT_PATH=$PWD;
export CURRENT_BRANCH=$(git symbolic-ref --short HEAD);

unset PROJECT_PATH;
unset TEST_PATH;
unset KNOWN_BAD_COMMIT;
unset KNOWN_GOOD_COMMIT;

. ./load-environment-variables.sh

# -- END: LOAD ENVIRONMENT VARIABLES --


# -- START: VALIDATE ENVIRONMENT VARIABLES --

echo "Validating relevant environment variables\n";

if [[ -z "${PROJECT_PATH}" ]]; 
then
    echo "The environment variable 'PROJECT_PATH' must be set and non-empty\n";
    return;
fi

if [[ -z "${TEST_PATH}" ]]; 
then
    echo "The environment variable 'TEST_PATH' must be set and non-empty\n";
    return;
fi

if [[ -z "${TEST_BRANCH_NAME}" ]]; 
then
    echo "The environment variable 'TEST_BRANCH_NAME' must be set and non-empty\n";
    return;
fi

if [[ -z "${KNOWN_BAD_COMMIT}" ]]; 
then
    echo "The environment variable 'KNOWN_BAD_COMMIT' must be set and non-empty\n";
    return;
fi

if [[ -z "${KNOWN_GOOD_COMMIT}" ]]; 
then
    echo "The environment variable 'KNOWN_GOOD_COMMIT' must be set and non-empty\n";
    return;
fi


# -- END: VALIDATE ENVIRONMENT VARIABLES --

# -- START: GIT VALIDATION -- Validate that git is installed
echo "Validating git installation\n";

git --version &> /dev/null
GIT_IS_AVAILABLE=$?

if [ $GIT_IS_AVAILABLE -ne 0 ]; then
    echo "The program 'git' is currently not installed.  You can install it by typing:
          sudo apt-get install git\n";
    exit 0;
fi

# -- END: GIT VALIDATION --

# ---------------------------------------------------------------------------------------------------------------- #

# -- START: ACTION #1 - Navigate to the project folder --

cd $PROJECT_PATH;

# -- END: ACTION #1 - Navigate to the project folder --

# -- START: ACTION #2 - git bisect start --

echo "------------------------------------------------------\n\n";
echo "KNOWN_BAD_COMMIT: ${KNOWN_BAD_COMMIT}\n";
git show $KNOWN_BAD_COMMIT --no-patch --oneline --pretty
echo "\n";
echo "------------------------------------------------------\n\n";
echo "KNOWN_GOOD_COMMIT: ${KNOWN_GOOD_COMMIT}\n";
git show $KNOWN_GOOD_COMMIT --no-patch --oneline --pretty
echo "\n";
echo "------------------------------------------------------\n\n";

echo "RUN: git bisect start\n\n";
git bisect start $KNOWN_BAD_COMMIT $KNOWN_GOOD_COMMIT

# -- END: ACTION #2 - git bisect start --

# -- START: ACTION #3 - Bisect automatically all the way to the first bad or last good rev --

echo "\n";
echo "RUN: git bisect run\n\n";
git bisect run $TEST_PATH

# -- END: ACTION #3 - Bisect automatically all the way to the first bad or last good rev --

# -- START: ACTION #4 - Show the first bad commit --

# Stay on the first failing commit after bisect instead of going back to master
git bisect reset HEAD

# Check if the result is the first bad commit or last good commit
source $TEST_PATH &> /dev/null;
err=$?

# If the test pass on the result commit, checkout the next commit in line
if [ "$err" -eq 0 ]; then
    git log --reverse --pretty=%H ${TEST_BRANCH_NAME} | grep -A 1 $(git rev-parse HEAD) | tail -n1 | xargs git checkout
fi

# Show the first bad commit
echo "\nFIRST BAD COMMIT:\n";
git show --no-patch --oneline --pretty

# -- END: ACTION #4 - Show the first bad commit --

# -- START: ACTION #5 - End the bisect operation and checkout to last visited branch again --

git bisect reset &> /dev/null
git checkout $CURRENT_BRANCH &> /dev/null

# -- END: ACTION #5 - End the bisect operation and checkout to last visited branch again --

# ---------------------------------------------------------------------------------------------------------------- #

# -- START: LAST ACTION - Navigate back to the initial folder --

cd $CURRENT_PATH;

# -- END: LAST ACTION - Navigate back to the initial folder --
