#!/bin/sh

args=""
if [ -n $HOOK_SECRET ]; then
    args="$args -secret=$HOOK_SECRET"
fi

if [ -n $HOOK_PORT ]; then
    args="$args -addr=:$HOOK_PORT"
fi

if [ -n $MIRROR_DIR ]; then
    args="$args -dir=$MIRROR_DIR"
fi

args="$args -git=/usr/bin/git"

gitmirror $args
