#!/bin/bash

cmp_shell()
{
	FUNC_RET=0;
	MY_OUTFILE=/tmp/my_outfile;
	TST_OUTFILE=/tmp/tst_outfile;
	
	echo "$@" | $MY_SHELL > $MY_OUTFILE 2>&1;
	MY_RET=$?;
	echo "$@" | $TST_SHELL > $TST_OUTFILE 2>&1;
	TST_RET=$?;
	
	if [ "$(uname)" = "Linux" ];then
		DIFF_COLOR='--color=always'
	fi

	if [ "$MY_RET" != "$TST_RET" ];then
		echo "[ERROR]: Return values differs.";
		printf "\t%s\n" "$MY_RET <- $MY_SHELL $@";
		printf "\t%s\n" "$TST_RET <- $TST_SHELL $@";
		FUNC_RET=1;
	fi

	if ! diff "$MY_OUTFILE" "$TST_OUTFILE" > /dev/null;then							
		echo "[ERROR]: Output differs.";
		printf "%s                                                          | %s\n" "($MY_SHELL)" "($TST_SHELL)"
		FUNC_RET=1;
		diff -y "$MY_OUTFILE" "$TST_OUTFILE" $DIFF_COLOR
	elif [ "$VERBOSE" = on ];then
		printf '\n$> %s :\n\n%s\n\n$> %s :\n\n%s\n\n----------\n'  "$MY_SHELL"  "$(cat $MY_OUTFILE)" "$TST_SHELL" "$(cat $TST_OUTFILE)"
	fi
	rm "$MY_OUTFILE" "$TST_OUTFILE";
	return $FUNC_RET;
}

interactive()
{
	while IFS= read -r line; do
		cmp_shell $line;
	done
}

unit_no_arg()
{
	cmp_shell 'ls'
	cmp_shell 'pwd'
	cmp_shell 'echo'
	cmp_shell 'uname'
	cmp_shell 'arch'
	cmp_shell './executables/no_arg.sh'

}

unit_arg()
{
	cmp_shell echo Hello World
	cmp_shell ls ..
	cmp_shell uname -a
}

main()
{
	MY_SHELL='sh'
	TST_SHELL='bash --posix'
	INTERACTIVE="off"
	VERBOSE="off";
	for arg in $@;
	do
		if [ "$arg" = '-i' ];then
			INTERACTIVE="on";
		fi
		if [ "$arg" = '-v' ];then
			VERBOSE="on";
		fi
	done

	if [ "$INTERACTIVE" = "on" ];then
		interactive;
	else
		for test in "$@";do
			OUTPUT="$($test)";
			if [ -z "$OUTPUT" ];then
				printf '%-15s [OK]\n' "$test:";
			else
				printf '%-15s [KO]\n%s\n' "$test:" "$OUTPUT"
			fi
		done
	fi
}

main $@
