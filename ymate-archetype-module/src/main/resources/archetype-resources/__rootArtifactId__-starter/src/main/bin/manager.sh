#!/bin/bash
# shellcheck disable=SC2046
BASE_PATH="$(cd $(dirname "$0") || exit; pwd)"
# shellcheck disable=SC2046
RUN_JARs="$(ls "${BASE_PATH}"/*.jar)"
if [[ ${#RUN_JARs[@]} == 0 ]]; then
  echo "ERROR: Service startup file not found!"
  exit 1
fi

source "${BASE_PATH}"/env.sh

user="$(whoami)"
if [[ "${user}" != "${APP_USER}" ]];then
  echo "WARN: The current user '${user}' is inconsistent with the startup user '${APP_USER}'."
  echo "      Please confirm the logged in user or change the configuration file."
  exit 1
fi

start() {
  JAR=$1
  # shellcheck disable=SC2009
  process="$(ps -ef|grep java|grep "${JAR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "WARN: $JAR has been started! PID: $process"
    exit 1
  fi
  if [ ! -f "${APP_CONF_FILE}" ];then
    echo -e "WARN: Configuration file '${APP_CONF_FILE}' not found, starting with default configuration!"
  else
    echo "APP_CONF_FILE: ${APP_CONF_FILE}"
  fi
  echo "APP_STD_OUT: ${APP_STD_OUT}"
  echo "Starting ${JAR}"

  if [ ! -d "${APP_LOGS}" ]; then
    mkdir "${APP_LOGS}"
  fi

  nohup java -jar "${JAR}" &>"${APP_STD_OUT}"&
}

stop() {
  JAR=$1
  # shellcheck disable=SC2009
  process="$(ps -ef|grep java|grep "${JAR}"|awk '{print $2}')"
  if [[ -n ${process} ]];then
    echo "Stopping ${JAR}"
    kill "${process}"
  else
    echo "WARN: ${JAR} was not started!"
  fi
}

restart() {
  stop "$1"
  sleep 1
  start "$1"
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
elif [ "${action}" = "env" ] ;then
  env
else
  usage
fi
