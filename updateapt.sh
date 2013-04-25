#!/usr/bin/env bash

echo -ne "Do you want to refresh the repository cache? [y/N] "

read refresh
[ ${refresh} ==  "y" ] && sudo aptitude update
