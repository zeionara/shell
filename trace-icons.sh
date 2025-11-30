#!/bin/bash

trace () {
  for i in $(seq $1 $2); do echo -e "\u$(printf '%x' $i) $i $(printf '%x\n' $i)"; done
}

trace 58112 58339
trace 58874 59053
trace 59136 59333
trace 60000 60395
