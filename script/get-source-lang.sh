# set -x
source ./crowdin_token.sh
URL=https://api.crowdin.com/api/v2
# https://crowdin.com/project/gc-wizard/settings#api
PROJECT_ID=445424

#
# Source language
#
SOURCE_FILE_ID=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/files  \
  | jq '.data[0].data.id')
echo "source file id = $SOURCE_FILE_ID"

# Get url of the Source file
echo "get source file url..."
SOURCE_FILE_URL=$(curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/files/$SOURCE_FILE_ID/download  \
  | jq -r '.data.url')

# direct download
curl -s "$SOURCE_FILE_URL" -o ../assets/i18n/en.json

echo "assets/i18n/en.json replaced !"