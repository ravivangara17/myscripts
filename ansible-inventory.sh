#!/bin/bash

echo "oo-ansible-inventory" >> /tmp/oo-ansible-inventory.log
echo "$@" >> /tmp/oo-ansible-inventory.log

if [ "$ONEOPS_SERVER" == "" ]; then
  echo "No OneOps profile specified."
  exit 1
fi

if [ "$1" == "--list" ]; then
  # Output the list of hosts, such as:
  # {
  #   "groupname1": [ "host1", "host2" ],
  #   "groupname2": [ "host1", "host3" ]
  # }
  echo "{"
  echo "  \"compute\"      : [ \"10.224.40.149\", \"10.224.40.151\" ],"
  echo "  \"compute-master\" : [ \"10.224.40.15\" ]"
  echo "}"
elif [ "$1" == "--host" ]; then
  # Output the variables for the host, such as:
  #{
  #    "favcolor"   : "red",
  #    "ntpserver"  : "wolf.example.com",
  #    "monitoring" : "pack.example.com"
  #}
  echo "{ }"
elif [ "$1" == "--static" ]; then
  # Assume the first parameter is an assembly, and generate an inventory
  # file
  ASSEMBLY_NAME=$2
#  ENV_NAME=dev1

  ENV_NAME=`oo-rest-api GET $ONEOPS_ORG_NAME/assemblies/$ASSEMBLY_NAME/operations/environments | python -c '
import sys, json;
jsonData = json.load(sys.stdin)
for platformData in jsonData:
  print platformData["ciName"]
' |head -n 1`

  PLATFORM_NAME=`oo-rest-api GET $ONEOPS_ORG_NAME/assemblies/$ASSEMBLY_NAME/operations/environments/$ENV_NAME/platforms | python -c '
import sys, json;
jsonData = json.load(sys.stdin)
for platformData in jsonData:
  print platformData["ciName"]
' |head -n 1`

  if [ "$PLATFORM_NAME" == "" ]; then
    echo "No platforms found!"
    exit 1
  else
    echo "#Assembly:    $ASSEMBLY_NAME"
    echo "#Environment: $ENV_NAME"
    echo "#Platform:    $PLATFORM_NAME"
    echo ""

    # Get the compute IPs
    COMPUTE_COMPONENTS=`oneops design component list -a $ASSEMBLY_NAME -p $PLATFORM_NAME |grep compute`

    for COMPUTE_COMPONENT in $COMPUTE_COMPONENTS; do
      echo -e "[${COMPUTE_COMPONENT}]"
      oo-rest-api GET $ONEOPS_ORG_NAME/assemblies/$ASSEMBLY_NAME/operations/environments/$ENV_NAME/platforms/$PLATFORM_NAME/components/$COMPUTE_COMPONENT/instances?instances_state=all |python -c '
import sys, json;
jsonDAta = json.load(sys.stdin)
for ooInst in jsonDAta:
  print ooInst["ciAttributes"]["private_ip"]
print ""
'
    done
  fi
else
  echo "Unrecognized command [$1]"
fi
