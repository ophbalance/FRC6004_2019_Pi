#!/bin/bash

source ~/.profile
workon cv
python server.py &
python listen.py &
python ball-id.py &

