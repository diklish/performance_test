#!/bin/bash

#

export TARGET_PORT="777"
export TARGET_PATH=""
export TARGET_KEYWORD=""
export TARGET_HOST="0.0.0.0"

T_DIR=test/result
nameJMX=COMSTR


NOW=$(date +"%m_%d_%Y_%H_%M_%S")

R_DIR=${T_DIR}/report_$NOW
rm -rf ${R_DIR} > /dev/null 2>&1
mkdir -p ${R_DIR}

/bin/rm -f ${T_DIR}/${nameJMX}.jtl ${T_DIR}/${nameJMX}.log  > /dev/null 2>&1

./run.sh -Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} -JTARGET_PORT=${TARGET_PORT} \
	-JTARGET_PATH=${TARGET_PATH} -JTARGET_KEYWORD=${TARGET_KEYWORD} \
	-n -t ${T_DIR}/${nameJMX}.jmx -l ${T_DIR}/${nameJMX}_$NOW.jtl -j ${T_DIR}/${nameJMX}_$NOW.log \
	-e -o ${R_DIR}

echo "==== jmeter.log ===="
cat ${T_DIR}/${nameJMX}.log

echo "==== Raw Test Report ===="
cat ${T_DIR}/${nameJMX}.jtl

echo "==== HTML Test Report ===="
echo "See HTML test report in ${R_DIR}/index.html"
