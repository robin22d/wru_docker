#!/bin/bash

jmeter -n -t WRUTest.jmx -j testplan.log
echo "Finished ..." >> output.txt

