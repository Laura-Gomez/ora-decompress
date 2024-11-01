#!/bin/bash

PATH_BKUP=$1
#SHA_REMOTE=''

## EACH POSSIBLE COPIED RUN
for FILE in $(find ${PATH_BKUP} -name *md5_ora.txt);
do
	echo ${FILE}
	PROCESS=${FILE}'.process'
#	SHASUM=${FILE}'.shasum'
#	SHA_REMOTE=${FILE}'.remote.shasum'

	## ONLY PROCESS RUN THAT ARE NOT BEING PROCESSED
	if [ ! -f ${PROCESS} ]; then
    		touch ${PROCESS} || { echo "ERROR: No se pudo escribir el archivo ${PROCESS}, el cual vigila el proceso de copiado" | mail -s "Proceso de decompresión" lgomez@inmegen.gob.mx; exit 1; }

		DIR=$(dirname -- ${PROCESS})
		CHECK_FILE=${FILE}
		ERROR_FILE=${FILE}'.error'
		MD5_FILE=${FILE}'.chk'

		## CALCULATE SHASUM AND PROCEED ONLY IF THERE ARE NO DIFFERENCES
		./error_md5_ora.sh ${CHECK_FILE} ${ERROR_FILE} ${MD5_FILE} || { echo "ERROR: No se pudo realizar la verificación de integridad de la corrida ${DIR}, contacta al administrador" | mail -s "Proceso de decompresión" lgomez@inmegen.gob.mx; exit 1; }

		echo "DONE -- VERIFICACION DE INTEGRIDAD"

	#	find ${DIR} -type f -print0 | xargs -0 sha1sum | awk '{print $1}' | sha1sum > ${SHASUM}
#		cp ${SHASUM} ${SHA_REMOTE}	
#		diff -q ${SHASUM} ${SHA_REMOTE} 1>/dev/null

		if [ ! -f ${ERROR_FILE} ]; then
			
			## DECOMPRESS EACH ORA FILE
			for FILE_ORA in $(find $PATH_BKUP -name *.ora);
			do
				orad --rm ${FILE_ORA} || { echo "ERROR: No se pudo realizar la decompresión de los archivos ORA para la corrida ${DIR}, contacta al administrador" | mail -s "Proceso de decompresión" lgomez@inmegen.gob.mx; exit 1; }
			done
			echo "La decompresión de los archivos ORA en la carpeta ${DIR} ha terminado exitosamente" | mail -s "Término de decompresión" lgomez@inmegen.gob.mx
		else
			 echo "Los archivos en la carpeta ${DIR} muestran diferencias con respecto a los archivos de origen, por favor vuelve a hacer el RESPALDO" | mail -s "Error en el respaldo" lgomez@inmegen.gob.mx
		fi
		echo "DONE -- DECOMPRESIÓN"
	fi
done




