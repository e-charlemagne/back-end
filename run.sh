#  _  __          ______  _____  _  _______ _   _  _____    ____  _   _
# | | \ \        / / __ \|  __ \| |/ /_   _| \ | |/ ____|  / __ \| \ | |
# | |  \ \  /\  / / |  | | |__) | ' /  | | |  \| | |  __  | |  | |  \| |
# | |   \ \/  \/ /| |  | |  _  /|  <   | | | . ` | | |_ | | |  | | . ` |
# | |    \  /\  / | |__| | | \ \| . \ _| |_| |\  | |__| | | |__| | |\  |
# | |     \/  \/   \____/|_|  \_\_|\_\_____|_| \_|\_____|  \____/|_| \_|
# | |
# |_|
# | |
# | |
# | |
# | |
# | |
# | |
# |_|
# | |
# | |
# | |
# | |
# | |
# | |
# |_|  _______ _     _       _        __             _   _
# | | |__   __| |   (_)     (_)      / _|           | | | |
# | |    | |  | |__  _ ___   _ ___  | |_ ___  _ __  | |_| |__   ___
# | |    | |  | '_ \| / __| | / __| |  _/ _ \| '__| | __| '_ \ / _ \
# | |    | |  | | | | \__ \ | \__ \ | || (_) | |    | |_| | | |  __/
# | |    |_|  |_| |_|_|___/ |_|___/ |_| \___/|_|     \__|_| |_|\___|
# | |
# |_|
# | |
# | |
# | |
# | |
# | |
# | |
# |_|  ______     _                    _                 _                           _        _   _
# | | |  ____|   | |                  (_)               | |                         | |      | | (_)
# | | | |__ _   _| |_ _   _ _ __ ___   _ _ __ ___  _ __ | | ___ _ __ ___   ___ _ __ | |_ __ _| |_ _  ___  _ __
# | | |  __| | | | __| | | | '__/ _ \ | | '_ ` _ \| '_ \| |/ _ \ '_ ` _ \ / _ \ '_ \| __/ _` | __| |/ _ \| '_ \
# | | | |  | |_| | |_| |_| | | |  __/ | | | | | | | |_) | |  __/ | | | | |  __/ | | | || (_| | |_| | (_) | | | |
# | | |_|   \__,_|\__|\__,_|_|  \___| |_|_| |_| |_| .__/|_|\___|_| |_| |_|\___|_| |_|\__\__,_|\__|_|\___/|_| |_|
# | |                                             | |
# |_|                                             |_|


# #!/usr/bin/env sh
#
#export JAVA_HOME="C:/Users/32579/.jdks/openjdk-22.0.1"
#export PATH=$JAVA_HOME/bin:$PATH
#
#javac -version
#java -version
#
#echo "Running unit tests with profile 'test'..."
#./mvnw test -Ptest
#
#if [ $? -eq 0 ]; then
#  echo "Tests passed. Starting Spring Boot application with profile 'dev'..."
#  ./mvnw spring-boot:run -Pdev
#else
#  echo "Tests failed. Not starting the Spring Boot application."
#  exit 1
#fi

## ============================================================= ##
## ============================================================= ##
## ============================================================= ##
## ============================================================= ##
## ============================================================= ##
## ============================================================= ##

#MS_HOME=/opt/MY_MICRO_SERVICE_ROOT_DIRECTORY # <--- EDIT THIS LINE
#
## Actual file name of Micro Service (jar or war),
## ms-service.war or something-0.0.1-SNAPSHOT.jar, etc.
#MS_JAR=MY_SPRING_BOOT_APPLICATION-0.0.1-SNAPSHOT.war # <--- EDIT THIS LINE
## ^^^ that should relative to MS_HOME directory.
#
## Which username we should run as.
#RUNASUSER=USER_TO_RUN_AS; # <-- EDIT THIS LINE,
## if port number for spring boot is < 1024 it needs root perm.
#
#JAVA_HOME=/usr/local/jdk1.8.0_60; # <-- EDIT THIS, Where is your JDK/JRE?
#PATH=${JAVA_HOME}/bin:${PATH};
#SHUTDOWN_WAIT=20; # before issuing kill -9 on process.
#
#export PATH JAVA_HOME
#
#
## These options are used when micro service is starting
## Add whatever you want/need here... overrides application*.yml.
#OPTIONS="
#-Dserver.port=8080
#-Dspring.profiles.active=dev
#";
##=-= END OF CUSTOM CONFIGURATION =-=#
#
## Try to get PID of spring jar/war
#MS_PID=`ps fax|grep java|grep "${MS_JAR}"|awk '{print $1}'`
#export MS_PID;
#
## Function: run_as
#run_as() {
#    local iam iwant;
#
#    iam=$(id -nu);
#    iwant="$1";
#    shift;
#
#    if [ "${iam}" = "${iwant}" ]; then {
#    eval $*;
#    }
#    else {
#    /bin/su -p -s /bin/sh ${iwant} $*;
#    } fi;
#}
#
## Function: start
#start() {
#  pid=${MS_PID}
#  if [ -n "${pid}" ]; then {
#    echo "Micro service is already running (pid: ${pid})";
#  }
#  else {
#    # Start screener ms
#    echo "Starting micro service";
#    cd $MS_HOME
#    run_as ${RUNASUSER} java -jar ${OPTIONS} ./${MS_JAR};
#    # java -jar ${OPTIONS} ./${MS_JAR}
#  } fi;
#  # return 0;
#}
#
## Function: stop
#stop() {
#  pid=${MS_PID}
#  if [ -n "${pid}" ]; then {
#
#    run_as ${RUNASUSER} kill -TERM $pid
#
#    echo -ne "Stopping micro service module";
#
#    kwait=${SHUTDOWN_WAIT};
#
#    count=0;
#    while kill -0 ${pid} 2>/dev/null && [ ${count} -le ${kwait} ]; do {
#      printf ".";
#      sleep 1;
#      (( count++ ));
#    } done;
#
#    echo;
#
#    if [ ${count} -gt ${kwait} ]; then {
#      printf "process is still running after %d seconds, killing process" \
#    ${SHUTDOWN_WAIT};
#      kill ${pid};
#      sleep 3;
#
#      # if it's still running use kill -9
#      #
#      if kill -0 ${pid} 2>/dev/null; then {
#        echo "process is still running, using kill -9";
#        kill -9 ${pid}
#        sleep 3;
#      } fi;
#    } fi;
#
#    if kill -0 ${pid} 2>/dev/null; then {
#      echo "process is still running, I give up";
#    }
#    else {
#      # success, delete PID file, if you have used it with spring boot
#      # rm -f ${SPRING_BOOT_APP_PID};
#    } fi;
#  }
#  else {
#      echo "Micro service is not running";
#  } fi;
#
#  #return 0;
#}
#
## Main Code
#
#case $1 in
#  start)
#    start;
#    ;;
#  stop)
#    stop;
#    ;;
#  restart)
#    stop;
#    sleep 1;
#    start;
#    ;;
#  status)
#    pid=$MS_PID
#    if [ "${pid}" ]; then {
#      echo "Micro service module is running with pid: ${pid}";
#    }
#    else {
#      echo "Micro service module is not running";
#    } fi;
#    ;;
#esac
#
#exit 0;
