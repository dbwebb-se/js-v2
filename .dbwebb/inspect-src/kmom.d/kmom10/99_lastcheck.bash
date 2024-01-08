#!/usr/bin/env bash

pwd || exit

e() { exit; }; export -f e

echo "Do manual stuff, if needed (write e/exit to exit)?"
ls
bash
