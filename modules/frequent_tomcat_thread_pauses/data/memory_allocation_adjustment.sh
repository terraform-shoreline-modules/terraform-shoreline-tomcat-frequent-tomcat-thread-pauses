

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