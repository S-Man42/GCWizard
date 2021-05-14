# set -x

source ./crowdin_token.sh
URL=https://api.crowdin.com/api/v2
# https://crowdin.com/project/gc-wizard/settings#api
PROJECT_ID=445424
# BRANCH_ID=4 # master
BRANCH_NAME=master
ZIP=./tmp-i18n.zip
TMP=tmp-i18n-dir
TARGET_I18N=../../assets/i18n
#
# Target languages
#
# Build Project Translation
echo "build Project Translation and get new buildId..."
BUILD_ID=$(curl -s \
  -X POST \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  "$URL/projects/$PROJECT_ID/translations/builds"  \
  | jq '.data.id')
echo "Build $BUILD_ID in progress..."

if [ -z "$BUILD_ID" ]
then
  echo "Something goes wrong, BUILD_ID is empty"
  exit
fi

if [ "null" = "$BUILD_ID" ]
then
  echo "Something goes wrong BUILD_ID is null"
  exit
fi

echo "Wait end of build (10s)..."
sleep 10

echo "Query status again (should be finished):"
BUILD_STATUS=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  "$URL/projects/$PROJECT_ID/translations/builds"  \
  | jq -r '.data[0].data.status')

if [ "$BUILD_STATUS" != "finished" ]
then
  echo "Build status: $BUILD_STATUS"
  echo "Build is not finished. Retry later or increase pause"
  exit
fi

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
# can be in $BRANCH_NAME/ if manual build from UI...
# cp -r $TMP/de/$BRANCH_NAME/en.json ../assets/i18n/de.json
cp -r $TMP/de/en.json $TARGET_I18N/de.json
cp -r $TMP/fr/en.json $TARGET_I18N/fr.json

rm -rf $ZIP
rm -rf $TMP
echo "done !"