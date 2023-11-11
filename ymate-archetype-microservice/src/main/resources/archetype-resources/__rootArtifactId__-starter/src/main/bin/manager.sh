#!/bin/bash
BASE_PATH="$(cd $(dirname $0) || exit; pwd)"

RUN_JARs="$(ls "${BASE_PATH}"/*.jar)"
if [[ ${#RUN_JARs[@]} == 0 ]]; then
  echo "ERROR: Startup file was not found."
  exit 1
fi

source "${BASE_PATH}"/env.sh

start() {
  JAR=$1
  process="$(ps -ef|grep java|grep "${JAR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "WARN: $JAR already started! PID: $process"
    exit 1
  fi
  echo "JDK_JAVA_OPTIONS:" "${JDK_JAVA_OPTIONS}"
  echo "JAVA_TOOL_OPTIONS:" "${JAVA_TOOL_OPTIONS}"
  echo "Starting ${JAR}"
  cd $(dirname ${BASE_PATH}) || exit
  nohup java -jar "${JAR}" &
}

stop() {
  JAR=$1
  process="$(ps -ef|grep java|grep "${JAR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "Stopping ${JAR}"
    kill "${process}"
  else
    echo "WARN: $JAR not started!"
  fi
}

restart() {
  stop "$1"
  sleep 1
  start "$1"
}

usage() {
  echo "Usage: manager.sh <start|stop|restart>"
}

if [ ! $# == 1 ] ;then
    usage
    exit;
fi

action=$1

if [ "${action}" = "start" ] ;then
  for jar in ${RUN_JARs}; do
    if [[ ${jar} == *starter* ]]; then
      start "${jar}"
    fi
  done
elif [ "${action}" = "stop" ] ;then
  for jar in ${RUN_JARs}; do
    if [[ ${jar} == *starter* ]]; then
      stop "${jar}"
    fi
  done
elif [ "${action}" = "restart" ] ;then
  for jar in ${RUN_JARs}; do
    if [[ ${jar} == *starter* ]]; then
      restart "${jar}"
    fi
  done
else
   usage
fi
