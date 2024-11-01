#!/bin/bash

CHECK_FILE=$1
ERROR_FILE=$2
MD5_FILE=$3

DIR_ORA=$(dirname ${CHECK_FILE})

#MD5_FILE='checklist.chk'
find ${DIR_ORA} -name *fastq.ora -exec md5sum "{}" + >> ${MD5_FILE}

#echo "DONE md5sum"

cat ${MD5_FILE} | while read line 
do
	ORA=$(echo ${line} | cut -f2 | rev | cut -d'/' -f1 | rev )
#	echo ${line}
#	echo ${ORA}

	SUM_FX=$(echo ${line} | cut -d' ' -f1)

	SUM_bkup=$(grep ${ORA} ${CHECK_FILE} | head -1 |  cut -d',' -f1)
        
#	echo "RESULTADOS"
#	echo $ORA 
#	echo $SUM_FX
#        echo $SUM_bkup

	if [ "${SUM_bkup}" != "${SUM_FX}" ]
       	then
 # 		echo "no son iguales"
		touch ${ERROR_FILE}
	fi

done


