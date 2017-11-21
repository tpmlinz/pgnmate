#!/bin/bash

export LOGFILE=src/test/resources/log4j.properties
export RESOURCES=src/test/resources
export PACKAGE=target/pgntools-0.0.1-SNAPSHOT.jar
export APP="java -Dlog4j.configuration=$LOGFILE -jar $PACKAGE"

# source this and then
# $APP -v (prints version)
