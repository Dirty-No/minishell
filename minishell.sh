#!/bin/bash --posix
export PS1='$(pwd): '
while IFS= read -r line; do eval $line ; printf $PS1 ; done