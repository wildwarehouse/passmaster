#!/bin/sh

while ! git push $(git rev-parse --abbrev-ref HEAD)
do
    sleep 10s
done