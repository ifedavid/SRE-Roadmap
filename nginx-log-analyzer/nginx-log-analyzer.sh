#!/bin/bash

# Script to analyze nginx logs and categorise them.

echo "Top 5 IP addresses with most requests:"
awk '{print $1}' < nginx-access.log | uniq -c | sort -r | head -n5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\n"

echo "Top 5 most requested paths:"
sed -n 's/.*GET \(\/[^ ]*\) HTTP\/1.1.*/\1/p' nginx-access.log | sort | uniq -c | sort -r | head -n5 | awk '{print $2 " - " $1 " requests"}'

echo -e "\n"

echo "Top 5 response status codes:"
sed -n 's/.*HTTP\/1.1" \([^ ]*\) [0-9].*/\1/p' nginx-access.log | sort | uniq -c | sort -r | head -n5 | awk '{print $2 " - " $1 " requests"}'