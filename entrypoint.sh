#!/bin/bash -e

# If running the rails server then create or migrate existing database
if [ "${*}" == "bundle exec thrust ./bin/rails server" ]; then
  ./bin/rails db:prepare
fi

if [[ -n "${RAILWAY_SERVICE_ID}" ]]; then
  echo "Detected railway environment with port ${PORT}"
  exec env HTTP_PORT="${PORT}" "${@}"
else
  echo "Not running in Railway, exec-ing as normal"
  exec "${@}"
fi
