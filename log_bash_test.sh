#!/bin/bash

# Path to your Spring Boot application jar
JAR_PATH="/path/to/your/application.jar"

# Log file path
LOG_FILE="/path/to/logs/myapp.log"

# Start the Java process and redirect output to log file
java -jar $JAR_PATH > $LOG_FILE 2>&1 &
