#!/bin/bash
set -e

DIR=$(dirname $(realpath "$0")) 	# locate folder where this sh-script is located in

cd $DIR
echo "Switched to ${DIR}"

git pull

# Drop old figures with forecasts
rm -rf ./figures/*.png

# Execute gretl job
gretlcli -b -e -q ./script/run.inp

if [ $? -eq 0 ]
then
  echo "Finished analysis"
  rm string_table.txt
  exit 0
else
  echo "Failure: Some error occured."
  rm string_table.txt
  exit 1
fi


git add .
git commit -m "update to $(date '+%Y-%m-%d')"
git push
