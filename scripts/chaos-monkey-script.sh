#!/bin/bash
#set -x

for pod in $(kubectl -n $NAMESPACE get pods -l chaosmonkeytarget=yes --no-headers | awk {'print $1'} | shuf -n $NR_POD_TO_KILL) 
do 
  kubectl -n $NAMESPACE delete pod $pod > /dev/null 2>&1
  DATE=$(date -u)
  echo "$DATE - killed pod $pod. Wait ($TIME_INTERVAL)s for next action."
  sleep $TIME_INTERVAL
done