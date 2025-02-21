#! /bin/bash

# G1 Collector latency optimized
# - MaxGCPauseMillis - 200 ms (250 default)
# - AlwaysPreTouch - for latency touch all the pages
# - InitiatingHeapOccupancyPercent - during young collection; threshold of old gen before kicking of 'concurrent start'
#     70% (45% default)
# - MaxRAMPercentage - size of Heap relative to the available memory in the container/vm 80%
# - OmitStackTraceInFastThrow - Repeat intrinsic JVM exceptions (default no-repeat)
# - StartFlightRecording - Starts the blackbox recorder which provides continuous recording, dumps at exit
# - PrintFinalFlag - Dump JVM config struct
JAVA_OPTS="-XX:+UseG1GC \
            -XX:MaxGCPauseMillis=200 \
            -XX:+AlwaysPreTouch \
            -XX:InitiatingHeapOccupancyPercent=70 \
            -XX:MaxRAMPercentage=50 \
            -XX:InitialRAMPercentage=50 \
            -XX:-OmitStackTraceInFastThrow \
            -XX:+PrintFlagsFinal \
            -XX:+HeapDumpOnOutOfMemoryError \
            -XX:HeapDumpPath=/service/dumps"


while [ true ]
do
     java  -jar /app/bin/anurag-test-0.0.1-SNAPSHOT.jar
     sleep 3
done
#exec java $JAVA_OPTS -jar /app/bin/anurag-test-0.0.1-SNAPSHOT.jar