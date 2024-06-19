#!/usr/bin/env sh

export JAVA_HOME="C:/Users/32579/.jdks/openjdk-22.0.1"
export PATH=$JAVA_HOME/bin:$PATH

javac -version
java -version

echo "Running unit tests with profile 'test'..."
./mvnw test -Ptest

if [ $? -eq 0 ]; then
  echo "Tests passed. Starting Spring Boot application with profile 'dev'..."
  ./mvnw spring-boot:run -Pdev
else
  echo "Tests failed. Not starting the Spring Boot application."
  exit 1
fi



