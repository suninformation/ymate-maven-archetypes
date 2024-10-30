#!/bin/bash
# shellcheck disable=SC2046
BASE_PATH="$(cd $(dirname "$0") || exit; pwd)"
# shellcheck disable=SC2046
CLASSES_PATH="$(cd $(dirname "${BASE_PATH}") || exit; pwd)/classes"
# shellcheck disable=SC2046
RUN_DIR="$(cd $(dirname "${BASE_PATH}") || exit; pwd)"

source "${BASE_PATH}"/env.sh

user="$(whoami)"
if [[ "${user}" != "${APP_USER}" ]];then
  echo "WARN: The current user '${user}' is inconsistent with the startup user '${APP_USER}'."
  echo "      Please confirm the logged in user or change the configuration file."
  exit 1
fi

start() {
  # shellcheck disable=SC2009
  process="$(ps -ef|grep java|grep "${RUN_DIR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "WARN: $RUN_DIR has been started! PID: $process"
    exit 1
  fi
  if [ ! -f "${APP_CONF_FILE}" ];then
    echo -e "WARN: Configuration file '${APP_CONF_FILE}' not found, starting with default configuration!"
  else
    echo "APP_CONF_FILE: ${APP_CONF_FILE}"
  fi
  echo "APP_STD_OUT: ${APP_STD_OUT}"
  echo "Starting ${RUN_DIR}"

  if [ ! -d "${APP_LOGS}" ]; then
    mkdir "${APP_LOGS}"
  fi

  nohup java -classpath "${CLASSES_PATH}" net.ymate.module.embed.Main --homeDir "${RUN_DIR}"/webapp &>"${APP_STD_OUT}"&
}

stop() {
  # shellcheck disable=SC2009
  process="$(ps -ef|grep java|grep "${RUN_DIR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "Stopping ${RUN_DIR}"
    kill "${process}"
  else
    echo "WARN: ${RUN_DIR} was not started!"
  fi
}

restart() {
  stop
  sleep 1
  start
}

usage() {
  echo "Usage: manager.sh <start|stop|restart|env>"
}

env() {
  echo "JDK_JAVA_OPTIONS: ${JDK_JAVA_OPTIONS}"
  echo "JAVA_TOOL_OPTIONS: ${JAVA_TOOL_OPTIONS}"
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
elif [ "${action}" = "env" ] ;then
  env
else
  usage
fi
