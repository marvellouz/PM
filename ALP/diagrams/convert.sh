#!/bin/bash
for i in *.svg; do rsvg-convert $i -z 1.5 -d 240 -p 240 -o ${i%svg}png; done
