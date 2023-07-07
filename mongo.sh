#!/bin/bash

alias mhc='NODE_OPTIONS='"'""'"' mongosh --host "$MONGO_HOST" --port "$MONGO_PORT" --username "$MONGO_USERNAME" --password "$MONGO_PASSWORD"'
