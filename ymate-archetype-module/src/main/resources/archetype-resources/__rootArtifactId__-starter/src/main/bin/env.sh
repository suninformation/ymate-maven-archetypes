#!/bin/bash

export APP_CONF_PATH=${APP_CONF_PATH:-/opt/conf}
export APP_DATA_PATH=${APP_DATA_PATH:-/data}
export APP_RUN_ENV=${APP_RUN_ENV:-}
export APP_USER=${APP_USER:-deploy}

export APP_LOGS=${APP_LOGS:-~}
export MEM=${MEM:-}

# shellcheck disable=SC2046
BASE_PATH="$(cd $(dirname "$0") || exit; pwd)"
DIR_NAME="$(dirname "${BASE_PATH}")"
PACKAGE_NAME="$(basename "${DIR_NAME}")"

# shellcheck disable=SC2001
APP_VERSION=$(echo "${PACKAGE_NAME}" | sed 's/.*\([0-9].[0-9].[0-9]\).*/\1/g')
export APP_NAME=${PACKAGE_NAME%-"${APP_VERSION}"*}
# shellcheck disable=SC2155
if [ -f "/proc/stat" ]; then
  export CPU_COUNT="$(grep -c 'cpu[0-9][0-9]*' /proc/stat)"
fi
#ulimit -c unlimited

if [[ -n ${APP_RUN_ENV} ]]; then
  export APP_CONF_FILE="${APP_CONF_PATH}/${APP_NAME}/ymp-conf_${APP_RUN_ENV}.properties"
else
  export APP_CONF_FILE="${APP_CONF_PATH}/${APP_NAME}/ymp-conf.properties"
fi

export APP_STD_OUT="${APP_LOGS}/${APP_NAME}_std_out.log"

JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -server"

if [[ -n ${MEM} ]]; then
  JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS}  ${MEM}"
else
  # shellcheck disable=SC2002
  if [ -f "/proc/meminfo" ]; then
    memTotal=$(cat /proc/meminfo | grep MemTotal | awk '{printf "%d", $2/1024*0.75 }')
    if [ "${memTotal}" -gt 60000 ]; then
      JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -Xms4g -Xmx4g"
      JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -Xmn2g"
    else
      JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -Xms2g -Xmx2g"
      JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -Xmn1g"
    fi
  fi
fi

JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:MetaspaceSize=256m -XX:MaxMetaspaceSize=256m"
JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:MaxDirectMemorySize=1g"
JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:SurvivorRatio=10"
#JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:+UseConcMarkSweepGC -XX:CMSMaxAbortablePrecleanTime=5000"
#JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:+CMSClassUnloadingEnabled -XX:CMSInitiatingOccupancyFraction=80 -XX:+UseCMSInitiatingOccupancyOnly"
#JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:+ExplicitGCInvokesConcurrent -Dsun.rmi.dgc.server.gcInterval=2592000000 -Dsun.rmi.dgc.client.gcInterval=2592000000"
if [[ -n ${CPU_COUNT} ]]; then
  JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:ParallelGCThreads=${CPU_COUNT}"
fi
#JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -Xloggc:${APP_LOGS}/${APP_NAME}_gc.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps"
JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=${APP_LOGS}/${APP_NAME}_java.hprof"

JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} --add-opens=java.base/java.lang=ALL-UNNAMED"
JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} --add-opens=java.base/java.io=ALL-UNNAMED"
JDK_JAVA_OPTIONS="${JDK_JAVA_OPTIONS} --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED"
export JDK_JAVA_OPTIONS

JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Djava.net.preferIPv4Stack=true"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Djava.security.egd=file:/dev/./urandom"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Djava.awt.headless=true"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Dsun.net.client.defaultConnectTimeout=10000"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Dsun.net.client.defaultReadTimeout=30000"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Dfile.encoding=UTF-8"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Dymp.configHome=${APP_CONF_PATH}/${APP_NAME}"
JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} -Dymp.configFile=${APP_CONF_FILE}"
export JAVA_TOOL_OPTIONS