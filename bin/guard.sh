#!/usr/bin/env ash

set -e

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$rspec" 2>/dev/null
}

trap _term SIGTERM

export NO_LOGS=true

# bundle exec rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 --keep-frame-binding -d -- ./bin/rspec
bundle exec guard

rspec=$!
wait "$rspec"
