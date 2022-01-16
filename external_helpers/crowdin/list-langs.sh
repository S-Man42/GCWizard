#
# https://support.crowdin.com/cli-tool/
# https://support.crowdin.com/configuration-file/#writing-a-simple-configuration-file
# https://support.crowdin.com/cli-tool/?q=Check%20the%20source%20paths%20in%20your%20configuration%20file
#
# Project Crowdin : https://crowdin.com/project/gc-wizard/content/files
#
# crowdin status
# crowdin list project
#
#
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
