# set -x
source ./crowdin_token.sh
URL=https://api.crowdin.com/api/v2
# https://crowdin.com/project/gc-wizard/settings#api
PROJECT_ID=445424
BRANCH_ID=4 # master
ZIP=./tmp-i18n.zip
TMP=tmp-i18n-dir

#
# Target languages
#

# Build Project Translation
echo "build Project Translation and get new buildId..."
BUILD_ID=$(curl -s \
  -X POST \
  -d '{"branchId": '$BRANCH_ID'}' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  "$URL/projects/$PROJECT_ID/translations/builds"  \
  | jq '.data.id')
echo "Build $BUILD_ID in progress..."

echo "Wait end of build (5s)..."
sleep 5

echo "Query status again (should be finished):"
curl -s \
  -d '{"branchId": '$BRANCH_ID'}' \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  "$URL/projects/$PROJECT_ID/translations/builds"  \
  | jq '.data.status'

# Get url of the zip file
echo "get zip url..."
JSON_DOWNLOAD=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/translations/builds/$BUILD_ID/download  \
)
DATA_URL=$(echo $JSON_DOWNLOAD  | jq -r '.data.url')

# Expiration (still work to do here...)
EXPIRE=$(echo $JSON_DOWNLOAD | jq -r '.data.expireIn')
echo "Build $BUILD_ID expires @ $EXPIRE"

# Download zip
echo "download zip for build $BUILD_ID..."
curl -s "$DATA_URL" -o $ZIP

echo "unzip..."
mkdir -p $TMP
unzip -o -q $ZIP -d $TMP

echo "copy target files..."
cp -r $TMP/de/en.json ../assets/i18n/de.json
cp -r $TMP/fr/en.json ../assets/i18n/fr.json

rm -rf $ZIP
rm -rf $TMP
echo "done !"