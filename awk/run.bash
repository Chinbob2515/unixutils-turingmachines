#! /bin/bash -x

awk -f source.awk -v INPUT="../adder.input" ../adder.tm
