#!/bin/bash

token=`cat \Users\akbar\token.txt`

curl -k -X GET -H 'Accept:application/json' -H "vmware-api-session-id: $token" https://10.10.10.50/rest/vcenter/datastore | python -m json.tool
