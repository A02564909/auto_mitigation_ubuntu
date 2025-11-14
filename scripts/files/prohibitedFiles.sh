#!/usr/bin/env bash
clear

# loop to search entire system for files that match extensions.txt file.
while IFS= read -r filename; do
    locate "$filename"
done < extensions.txt > results

read -p "Prohibited extensions listed in results file. Press Enter to continue."
