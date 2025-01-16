# wall_monitoring

This Bash script provides a concise and informative summary of important system statistics and status. It outputs various details about your system, including architecture, CPU, memory usage, disk usage, network configuration, and more.

---

## **Features**

The script gathers and outputs the following system information:

- **System Architecture and Kernel Version**  
  Displays system architecture (e.g., x86_64) and kernel version.

- **Physical CPU Processors**  
  Counts and displays the number of physical CPU processors.

- **Virtual CPU Processors (VCPUs)**  
  Displays the number of virtual CPU processors in the system.

- **Memory Usage**  
  Shows the used and total system memory, along with the percentage of memory usage.

- **Disk Usage**  
  Displays the used and total disk space on the root file system along with the usage percentage.

- **CPU Load**  
  Displays the current CPU load percentage (excluding idle time).

- **Last Boot Time**  
  Shows the date and time of the last system reboot.

- **LVM Status**  
  Checks and shows whether LVM (Logical Volume Manager) is being used on the system.

- **Active TCP Connections**  
  Displays the number of established TCP connections on the system.

- **User Logins**  
  Counts the number of users logged in, based on the `/etc/passwd` file.

- **Network Information**  
  Shows the system's IPv4 address and MAC address.

- **Sudo Command Usage**  
  Displays the number of sudo commands executed on the system, based on the sudo log.

---

## **Installation**

No installation is required. Simply copy the script and execute it on your Linux system.

---

## **Usage**

### **Running the System Info Script**

1. **Clone or Copy the Script**  
   Copy the contents of the `monitoring.sh` script or clone it from the repository to your system.

2. **Give Execution Permissions**  
   Make sure the script has executable permissions:

   ```bash
   chmod +x monitoring.sh
   ```

3. **Run the Script**  
   Execute the script by running the following command in your terminal:

   ```bash
   sudo ./monitoring.sh
   ```

### **Launcher Script**

In case you want to automate the monitoring process and display the system information to all users using `wall`, you can use the `launcher.sh` script.

1. **Copy the `launcher.sh` Script**  
   The `launcher.sh` script launches the `launcher.sh` script and broadcasts the output to all users.

2. **Give Execution Permissions to the Launcher Script**  
   Ensure the launcher script has execution permissions:

   ```bash
   chmod +x launcher.sh
   ```

3. **Run the Launcher Script**  
   Execute the launcher script to generate and broadcast the system information:

   ```bash
   sudo ./launcher.sh
   ```

   - This will run `monitoring.sh` (or `launcher.sh`) and direct the output to a temporary file `output`.
   - The `wall` command is then used to broadcast the output to all logged-in users.
   - Finally, the `output` file is deleted.

### Automated Display Using `watch`

To automate the display of system statistics across multiple machines, you can set up a recurring display with the following command:

```bash
watch -n 10 sudo ./launcher.sh
```

### Explanation:
- `watch`: This command runs the specified command at regular intervals.
- `-n 10`: This sets the interval to 10 seconds (you can adjust the value as needed).
- `sudo ./launcher.sh`: This runs the `launcher.sh` script, which in turn executes `monitoring.sh`, generating system statistics and broadcasting them to all users via the `wall` command.

By using this, you'll automatically broadcast updated system information on all machines every 10 seconds (or whatever interval you choose). This can be useful for continuous monitoring or displaying real-time status updates on multiple systems in a network.

---

This setup works well for showing live system data across all logged-in users, creating an automated dashboard that can be seen on every computer in the network.

### Output:
The script will provide a system report with sections like:
```
#ARCHITECTURE:              x86_64
#CPU PHYSICAL:              4
#VCPU:                      4
#MEMORY USAGE:              1234/4096MB (30.23%)
#DISK USAGE:                15/100GB (10%)
#CPU LOAD:                  20.0%
#LAST BOOT:                 2025-01-01 12:00:00
#LVM USE:                   yes
#TCP CONNECTIONS:           12 ESTABLISHED
#USER LOG:                  4
#NETWORK:                   IP 192.168.1.1 (00:14:22:01:01:01)
#SUDO:                      25 cmd
```
---

## **Dependencies**

This script relies on the following tools:

- `uname`
- `grep`
- `cut`
- `awk`
- `bc`
- `df`
- `top`
- `last`
- `lvm`
- `netstat`
- `ifconfig`
- `wall` (for broadcasting)
  
All of these tools are typically pre-installed on most Linux distributions.
