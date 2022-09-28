#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
${symbol_pound}!/bin/bash
cd ${symbol_dollar}(dirname ${symbol_dollar}0)
CURRENT_DIR=${symbol_dollar}(pwd)
cd ../lib
LIB_DIR=${symbol_dollar}(pwd)

MAIN_CLASS='net.ymate.platform.core.container.Main'
SERVER_NAME='${package}.Starter'

PIDS=${symbol_dollar}(ps -ef | grep java | grep "${symbol_dollar}LIB_DIR" | grep "${symbol_dollar}SERVER_NAME" | awk '{print ${symbol_dollar}2}')
if [ -n "${symbol_dollar}PIDS" ]; then
  echo "Start fail! ${symbol_dollar}SERVER_NAME already started! PID: ${symbol_dollar}PIDS"
  exit 1
fi

LIB_JARS=${symbol_dollar}(ls ${symbol_dollar}LIB_DIR | grep .jar | awk '{print "'${symbol_dollar}LIB_DIR'/"${symbol_dollar}0}' | tr "\n" ":")
cd ${symbol_dollar}(dirname ${symbol_dollar}CURRENT_DIR)

JDK_JAVA_OPTIONS="${symbol_dollar}JDK_JAVA_OPTIONS --add-opens=java.base/java.lang=ALL-UNNAMED"
JDK_JAVA_OPTIONS="${symbol_dollar}JDK_JAVA_OPTIONS --add-opens=java.base/java.io=ALL-UNNAMED"
JDK_JAVA_OPTIONS="${symbol_dollar}JDK_JAVA_OPTIONS --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED"
export JDK_JAVA_OPTIONS

JAVA_TOOL_OPTIONS="${symbol_dollar}JAVA_TOOL_OPTIONS -Djava.net.preferIPv4Stack=true"
export JAVA_TOOL_OPTIONS

nohup java -Dymp.mainClass=${symbol_dollar}SERVER_NAME -server -Xms1g -Xmx1g -classpath .:${symbol_dollar}LIB_JARS ${symbol_dollar}MAIN_CLASS nohup.out 2>&1 &

PIDS=${symbol_dollar}(ps -ef | grep java | grep "${symbol_dollar}LIB_DIR" | grep "${symbol_dollar}SERVER_NAME" | awk '{print ${symbol_dollar}2}')
if [ -z "${symbol_dollar}PIDS" ]; then
  echo "Start fail! ${symbol_dollar}SERVER_NAME not started!"
  exit 1
fi

echo "Start success! PID:"${symbol_dollar}PIDS
