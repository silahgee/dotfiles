#!/bin/bash

watch -n 1 '
echo "=== SYSTEM MEMORY ==="
free -h

echo
vmstat 1 2

echo
echo "=== OLLAMA MODELS ==="
ollama ps

echo
echo "=== OLLAMA PROCESSES ==="
printf " %-6s %-6s %6s %6s  %s\n" "PID" "USER" "%MEM" "RSS(KB)" "COMMAND"
ps -eo pid=,user=,%mem=,rss=,cmd= --sort=-rss | grep -i "[o]llama"
'
