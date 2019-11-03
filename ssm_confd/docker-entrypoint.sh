#!/bin/bash

if [ "${SSM_ENABLED}" == "true" ]
then

  echo "=> SSM enabled, reading all settings from SSM"
  PREFIX="-prefix /tamima"
  echo "=> Running confd with prefix ${PREFIX}..."
  # generate initial config
  confd -onetime -confdir=/etc/confd/ -backend=ssm ${PREFIX} -sync-only -log-level debug
  echo "=> Running confd in background with interval ${CONFD_INTERVAL}"
  # run confd in the background
  confd -confdir=/etc/confd/ -backend=ssm ${PREFIX} -interval=${CONFD_INTERVAL} &
fi

exec "$@"