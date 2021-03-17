# set -x
source ./crowdin_token.sh
URL=https://api.crowdin.com/api/v2
# https://crowdin.com/project/gc-wizard/settings#api
PROJECT_ID=445424
ZIP=./tmp-i18n.zip
TMP=tmp-i18n-dir

#curl \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/json' \
#  -H "Authorization: Bearer ${TOKEN}" \
#  ${URL}/projects  | jq '.'

# build project
echo "get buildId..."
BUILD_ID=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/translations/builds  \
  | jq '.data[0].data.id')
echo "Build $BUILD_ID"

# Get url of the zip file
echo "get zip url..."
DATA_URL=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/translations/builds/$BUILD_ID/download  \
  | jq -r '.data.url')

# Download zip
echo "download zip..."
curl -s $DATA_URL -o $ZIP

echo "unzip..."
mkdir -p $TMP
unzip -o -q $ZIP -d $TMP

echo "copy files..."
cp -r $TMP/de/en.json ../assets/i18n/de.json
cp -r $TMP/fr/en.json ../assets/i18n/fr.json

rm -rf $ZIP
rm -rf $TMP
echo "done !"