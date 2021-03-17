#!/bin/bash


liste=("un" "deux" "trois")

for i in ${liste[@]}; do # * ou @
  echo $i
done
