
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Frequent Tomcat Thread Pauses
---

Tomcat Thread Pauses is a type of incident that occurs when the Tomcat server experiences frequent pauses in its threads. This can cause delay in server response time and may lead to application downtime. This issue can be caused by a variety of factors such as incorrect configuration, excessive load on the server, or memory leaks in the application code. It is important to investigate and resolve this issue promptly to ensure smooth functioning of the application.

### Parameters
```shell
export TOMCAT_PROCESS_NAME="PLACEHOLDER"

export TOMCAT_LOG_FILE="PLACEHOLDER"

export NEW_MEMORY_SIZE="PLACEHOLDER"

export PATH_TO_TOMCAT_DIRECTORY="PLACEHOLDER"
```

## Debug

### Get the process ID of the Tomcat instance
```shell
TOMCAT_PID=$(pgrep -f ${TOMCAT_PROCESS_NAME})
```

### Check the CPU and memory usage of the Tomcat process
```shell
top -p $TOMCAT_PID
```

### Check if there are any errors or warnings in the Tomcat logs
```shell
tail -f ${TOMCAT_LOG_FILE}
```

### Check the status of the Tomcat threads
```shell
jstack $TOMCAT_PID
```

### Check the number of open file descriptors by the Tomcat process
```shell
lsof -p $TOMCAT_PID | wc -l
```

### Check the network connections of the Tomcat process
```shell
netstat -nap | grep $TOMCAT_PID
```

## Repair

### Increase the memory allocation of the JVM to ensure that there is enough memory available for the Tomcat server to run efficiently.
```shell


#!/bin/bash



# set the path to the Tomcat installation directory

TOMCAT_DIR=${PATH_TO_TOMCAT_DIRECTORY}



# set the new memory allocation size

NEW_MEM_SIZE=${NEW_MEMORY_SIZE}



# stop the Tomcat server

$TOMCAT_DIR/bin/shutdown.sh



# set the new memory allocation size in the Tomcat startup script

sed -i "s/-Xmx[0-9]*[mMgG]/-Xmx$NEW_MEM_SIZE/g" $TOMCAT_DIR/bin/startup.sh



# start the Tomcat server

$TOMCAT_DIR/bin/startup.sh


```