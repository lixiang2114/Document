#!/usr/bin/env bash
while true;do
  tailf /install/test/mylogger.log 2>/dev/null
  sleep 1s
done
