#!/bin/bash
# Script para generar pareja de certificados

if [[ "$1" = "" ]]; then
	echo 'Debe introducir el nombre a la pareja de certificados.';
else
	file_name=$1
	dire="./certificados/${file_name}"
	if [[ "$2" = "" ]]; then
		echo "C:";
		read $var_C;
		echo "ST:";
		read $var_ST;
		echo "L:";
		read $var_L;
		echo "O:";
		read $var_O;
		echo "OU:";
		read $var_OU;
		echo "CN:";
		read $var_CN;
		echo "ALT NAMES:";
		read $var_ALT_NAMES;

		vars="/C=${var_C}/ST=${var_ST}/L=${var_L}/O=${var_O}/OU=${var_OU}/CN=${var_CN}/subjectAltName=${var_ALT_NAMES}/"

	else
		vars=$2

	fi

	mkdir -p "${dire}"

	openssl req -new -sha256 -nodes -key rsa -subj ${vars} > $dire/$file_name.csr

	openssl x509 -req -days 365 -in $dire/$file_name.csr -signkey rsa -extensions v3_req > $dire/$file_name.cer
fi
