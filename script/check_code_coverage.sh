#!/bin/bash
set -e

# To get coverage of only changed files you can run
# sh .ci_scripts/coverage/coverage_changed_file.sh
# with parameter -- as black means only uncommitted changed files
# with parameter -- greater than 0 means number of commits
# for example
# sh .ci_scripts/coverage/coverage_changed_file.sh 1 --  will check changed in 1 last commit
# sh .ci_scripts/coverage/coverage_changed_file.sh --  will check changed uncommitted files only

rm -rf coverage
mkdir coverage
touch coverage/lcov.base.info

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

remove=('lib/main.dart' \
        'lib/generated/l10n.dart' \
        'lib/generated/**' \
        'lib/gen/**' \
        'lib/data/**' \
        'lib/route/**' \
         'lib/theme/**' )
removeFiles=""
files=$(git diff --name-only main lib)
arr=($files)

for p in "${remove[@]}"; do
  removeFiles+=" $p"
  arr=( "${arr[@]/$p}" )
done

nonTestFiles=""
testFiles=""
for file in ${arr[@]}; do
  if [[ "$file" == *".dart"* ]]; then
    if [[ "$file" == *"test"* ]]; then
      echo "${GREEN} testing --- written tests for $file  ${NC}"
      temp=${file/"_test"/""}

      if [[ $file == *"packages"* ]]; then
        tail="${file#*/*/}"
        head="${file%/$tail}"
        # shellcheck disable=SC2046
        testFiles+=" $(find $head -name $(basename "$temp"))"
        cd $head
        flutter test --coverage "$tail"
        var1=lib/
        var2=$head/lib/
        LOCAL_COVERAGE_FILE_PATH="coverage/lcov.info"
        sed -i '' -e "s@${var1}@${var2}@" "${LOCAL_COVERAGE_FILE_PATH}"
        cat coverage/lcov.info >>../../coverage/lcov.base.info

        rm -rf coverage/lcov.info
        cd ..
        cd ..

      else
        module="lib"
        testFiles+=" $(find $module -name $(basename $temp))"
        flutter test --coverage "$file"
        cat coverage/lcov.info >>coverage/lcov.base.info
      fi
    else
      nonTestFiles+=" $file"
    fi
  fi
done

for file in ${arr[@]}; do
  if [[ "$file" == *".dart"* ]]; then

    file=${file/".dart"/""}
    if [[ "$file" != *"test"* && "$testFiles" != *"$(basename "$file")"* ]]; then
        dir="test"
        if [[ $(find $dir -name "$(basename $file)_test[.]dart") == "" ]]; then
          createFile="test/$(basename $file)_test.dart"

          touch $createFile
          echo "\n${GREEN} Temporary file created to find coverage ${BLUE}$createFile${NC}"
          tee "$createFile" <<< "import 'package:flutter_test/flutter_test.dart'; void main() {test('', () {});}"

          echo "${GREEN} testing --- changed in $file detected.${NC}"
          flutter test --coverage "$createFile"
          rm -rf "$createFile"
          echo "\n${RED} Deleted ${BLUE}$createFile${NC}"

          cat coverage/lcov.info >>coverage/lcov.base.info
          rm -rf coverage/lcov.info
          continue
        fi
        echo "${GREEN} testing --- changed in $file detected.${NC}"
        flutter test --coverage $(find test -name "$(basename "$file")_test[.]dart")
        cat coverage/lcov.info >>coverage/lcov.base.info
        rm -rf coverage/lcov.info
    fi
  fi
done

echo "\n Tested : $testFiles \n $nonTestFiles \n"

lcov --remove coverage/lcov.base.info $removeFiles -o coverage/lcov.base.info

sh lcov -e coverage/lcov.base.info $nonTestFiles $testFiles -o coverage/lcov.base.info

echo "generating html..."
genhtml coverage/lcov.base.info -o coverage/html
open coverage/html/index.html
