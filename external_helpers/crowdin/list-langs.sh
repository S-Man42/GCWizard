# set -x
source ./crowdin_token.sh
URL=https://api.crowdin.com/api/v2
# https://crowdin.com/project/gc-wizard/settings#api
PROJECT_ID=445424

#echo "List files:"
#curl -s \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/json' \
#  -H "Authorization: Bearer $TOKEN" \
#  $URL/projects/$PROJECT_ID/files  | jq '.'
#
#echo "Info project:"
#curl -s \
#  -H 'Accept: application/json' \
#  -H 'Content-Type: application/json' \
#  -H "Authorization: Bearer $TOKEN" \
#  $URL/projects/$PROJECT_ID  | jq '.'

echo "List builds:"
curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/translations/builds  | jq '.'

# Branch master : 4
echo "List branches:"
curl -s \
  -H 'Accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $TOKEN" \
  $URL/projects/$PROJECT_ID/branches  | jq '.'
