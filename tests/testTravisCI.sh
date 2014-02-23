#!/bin/bash -x
#
#  Sample test driver that allows for customizing build/tests based on env vars defined in .travis.yml
#
#      -verbose flag causes unconditional transcript display
#
# Copyright (c) 2013 VMware, Inc. All Rights Reserved <dhenrich@vmware.com>.
#

echo "--->$TRAVIS_BUILD_DIR"
echo "`pwd`"

if [ "${CONFIGURATION}x" = "x" ]; then
  if [ "${BASELINE}x" = "x" ]; then
    echo "Must specify either BASELINE or CONFIGURATION"
    exit 1
  else
    PROJECT_LINE="  baseline: '${BASELINE}';"
    VERSION_LINE=""
    FULL_CONFIG_NAME="BaselineOf${BASELINE}"
  fi
else
  PROJECT_LINE="  configuration: '${CONFIGURATION}';"
  VERSION_LINE="  version: '$VERSION';"
  FULL_CONFIG_NAME="ConfigurationOf${CONFIGURATION}"
fi

if [ "${REPOSITORY}x" = "x" ]; then
  echo "Must specify REPOSITORY"
  exit 1
fi
REPOSITORY_LINE="  repository: '$REPOSITORY';"

OUTPUT_PATH="${PROJECT_HOME}/tests/travisCI.st"

cat - >> $OUTPUT_PATH << EOF
(Smalltalk includesKey: #UserGlobals) ifTrue:[
 "Load latest GLASS1 when on Gemstone"
 [ Metacello new
    baseline: 'GLASS1';
    repository: 'github://glassdb/glass:master/repository';
    load.
  ] on: Warning
    do:[:ex | Transcript show: ex greaseString. ex resume].
].

 Transcript cr; show: 'travis--->${OUTPUT_PATH}'.
 "Load the configuration or baseline"
 Metacello new
 $PROJECT_LINE
 $VERSION_LINE
 $REPOSITORY_LINE
   load: #( ${LOADS} ).
  "Run the tests"
  Smalltalk at: #Author ifPresent:[:author | author fullName: 'Travis'].
  TravisCIHarness
    value: #( '${FULL_CONFIG_NAME}' )
    value: 'TravisCISuccess.txt' 
    value: 'TravisCIFailure.txt'.
EOF

cat $OUTPUT_PATH

$BUILDER_CI_HOME/testTravisCI.sh "$@"
if [[ $? != 0 ]] ; then exit 1; fi