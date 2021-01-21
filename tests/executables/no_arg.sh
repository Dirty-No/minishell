#!/bin/bash

#to have no input :
#printf "" | no_arg.sh 

INPUT=$(cat <&0)

if ! [ -z "$INPUT" ];then
	exit -1;
fi

echo $#
exit $#
