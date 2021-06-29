#!/bin/sh

# Launch monitoring.sh => generate output
bash /home/wall_monitoring/monitoring.sh > output

# Broadcast output using wall
wall -t 15 output

# Erase output file
rm -f output
