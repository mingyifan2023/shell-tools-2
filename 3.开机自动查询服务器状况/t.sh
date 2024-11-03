#!/bin/bash




# bash /home/ansible-app/t.sh

#追加到  /etc/rc.local 中  echo ""  >> /etc/rc.local
# sudo chmod +x /etc/rc.local




# Function to highlight percentage based on threshold
highlight_percentage() {
    percentage=$1
    if (( $(echo "$percentage > 80" | bc -l) )); then
        echo -e "\e[31m$percentage%\e[0m"
    elif (( $(echo "$percentage > 50" | bc -l) )); then
        echo -e "\e[34m$percentage%\e[0m"
    else
        echo -e "\e[32m$percentage%\e[0m"
    fi
}

# System Info
echo "-------------------------------------"
echo "           [System Info]             "
echo "-------------------------------------"
#echo "Last login: $(last | head -n 1 | awk '{print $1, $4, $5}')"
echo "Last login: $(last | head -n 1) "
echo "Current time: $(date)"
echo "Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f 2 | tr -d '\"')"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime | awk '{print $3, $4}' | sed 's/,//')"
echo "IP Address: $(hostname -I | awk '{print $1}')"
echo "Hostname: $(hostname)"
echo "CPU: $(lscpu | grep 'Model name' | cut -d ':' -f 2 | xargs)"

# Memory Info
mem_info=$(free -m)
mem_all=$(free )
memory_total_mb=$(echo "$mem_info" | grep Mem | awk '{print $2}')
memory_used_mb=$(echo "$mem_info" | grep Mem | awk '{print $3}')
memory_total_old=$(echo "$mem_all" | grep Mem | awk '{print $2}')
memory_used_old=$(echo "$mem_all" | grep Mem | awk '{print $3}')
memory_percent=$(awk "BEGIN {printf \"%.1f\", ($memory_used_old/$memory_total_old) * 100}")
echo "Memory Total: ${memory_total_mb}MB Used: ${memory_used_mb}MB ($(highlight_percentage $memory_percent))"

# Swap Info
swap_total_gb=$(echo "$mem_info" | grep Swap | awk '{print $2}')
swap_used_gb=$(echo "$mem_info" | grep Swap | awk '{print $3}')
swap_percent=$(awk "BEGIN {printf \"%.1f\", ($swap_used_gb/$swap_total_gb) * 100}")
echo "Swap Total: ${swap_total_gb}GB Used: ${swap_used_gb}GB ($(highlight_percentage $swap_percent))"

echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}')"
echo "Number of processes: $(ps aux | wc -l)"
echo "Users logged on: $(who | wc -l)"
echo "Last reboot: $(who -b)"

# Filesystem info
echo ""
echo "-------------------------------------"
echo "       [Filesystem Info]             "
echo "-------------------------------------"
df -h | while read line; do
    used_percent=$(echo $line | awk '{print $5}' | tr -d '%')
    if (( $(echo "$used_percent > 80" | bc) )); then
        echo -e "\e[31m$line\e[0m"
    elif (( $(echo "$used_percent > 50" | bc) )); then
        echo -e "\e[34m$line\e[0m"
    else
        echo -e "\e[32m$line\e[0m"
    fi
done
