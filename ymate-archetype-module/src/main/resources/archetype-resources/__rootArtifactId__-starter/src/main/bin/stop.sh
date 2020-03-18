#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
${symbol_pound}!/bin/bash
cd ${symbol_dollar}(dirname ${symbol_dollar}0)
cd ../lib
LIB_DIR=${symbol_dollar}(pwd)

MAIN_CLASS='net.ymate.platform.core.container.Main'
SERVER_NAME='${package}.Starter'

PIDS=${symbol_dollar}(ps -ef | grep java | grep "${symbol_dollar}LIB_DIR" | grep "${symbol_dollar}SERVER_NAME" | awk '{print ${symbol_dollar}2}')
if [ -z "${symbol_dollar}PIDS" ]; then
  echo "Stop fail! ${symbol_dollar}SERVER_NAME not started!"
  exit 1
fi

for PID in ${symbol_dollar}PIDS; do
  kill ${symbol_dollar}PID >/dev/null 2>&1
done
echo "Stop success! PID: ${symbol_dollar}PIDS"
