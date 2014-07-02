#!/usr/bin/env python

import os


sensors_data = os.popen('sensors | grep Core\ $1 | cut -d "(" -f 1 | cut -d "+" -f 2 | cut -c 1-4').readline()
result = max(sensors_data.split("\n"))
print result
