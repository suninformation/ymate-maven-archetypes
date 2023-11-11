#!/bin/bash
BASE_PATH="$(cd $(dirname $0) || exit; pwd)"
CLASSES_PATH="$(cd $(dirname ${BASE_PATH}) || exit; pwd)/classes"
RUN_DIR="$(cd $(dirname ${BASE_PATH}) || exit; pwd)"

source "${BASE_PATH}"/env.sh

start() {
  process="$(ps -ef|grep java|grep "${RUN_DIR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "WARN: $RUN_DIR already started! PID: $process"
    exit 1
  fi
  echo "JDK_JAVA_OPTIONS:" "${JDK_JAVA_OPTIONS}"
  echo "JAVA_TOOL_OPTIONS:" "${JAVA_TOOL_OPTIONS}"
  echo "Starting ${RUN_DIR}"

  nohup java -classpath "${CLASSES_PATH}" net.ymate.module.embed.Main --homeDir "${RUN_DIR}"/webapp &
}

stop() {
  process="$(ps -ef|grep java|grep "${RUN_DIR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "Stopping ${RUN_DIR}"
    kill "${process}"
  else
    echo "WARN: $RUN_DIR not started!"
  fi
}

restart() {
  stop
  sleep 1
  start
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
  start
elif [ "${action}" = "stop" ] ;then
  stop
elif [ "${action}" = "restart" ] ;then
  restart
else
  usage
fi
