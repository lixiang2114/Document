#!/usr/bin/env bash

NonZeros=(1 2 3 4 5 6 7 8 9)
AllNums=(0 1 2 3 4 5 6 7 8 9)
SchemaNames=(ServerLog ClientLog TestLog MonitorLog)
LoggerTypes=(InternalCallee ExternalCallee UIElement ScheduledTask DataVisitor FeatureChecker PerformanceMonitor Other)
RunningEnvironments=(NativeProcess GeneralContainer Kubernetes ServiceFabric)
OSTypes=(Android IOS MacOS Windows Linux Unix SingleProcess ChromeOS Other)
HardwarePlatforms=(Arm X86/64 RISC-V Other)
CodeLanguages=(Java C/C++ Objective-C JavaScript Python)
EventLevels=(Debug Info Warn Error Fatal)
EventCodes=(11236 21236 31236 41236 51236)
UpperLetters=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
AllLetters=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z)
ValueUnits=(Bit BitPerSeond Percentage Byte BytePerSecond Centigrade Count CountPerSecond Round RoundPerMinute Second Millisecond Other)

ProductId=3
SchemaName=\"ServerLog\"

for index in {1..100000};do
CreateTime=`date '+%F %T %N'|awk '{print $1" "$2" "substr($3,1,3)}'`

EventCode=${EventCodes[$[$RANDOM%5]]}

EventLevel=${EventLevels[$[${EventCode:0:1}-1]]}

LoggerName=${UpperLetters[$[$RANDOM%26]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}

ServiceNameStr=${UpperLetters[$[$RANDOM%26]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}

ServiceName=\"${ServiceNameStr}\"

NodeId=\"Product.$ServiceNameStr\"

InstanceIdStr=${ServiceNameStr}$[$RANDOM%9+1]$[$RANDOM%10]
InstanceId=\"${InstanceIdStr}\"

LoggerType=\"${LoggerTypes[$[$RANDOM%8]]}\"

Message="\"this is $InstanceIdStr logger message\""

CodeLanguage=\"${CodeLanguages[$[$RANDOM%5]]}\"

CodePath="\"com.bfw.test.${ServiceNameStr}.java\""

ValueUnit=\"${ValueUnits[$[$RANDOM%13]]}\"

Value=$[$RANDOM%1000+1].$[$RANDOM%100]

HardwarePlatform=\"${HardwarePlatforms[$[$RANDOM%4]]}\"

OSTypeStr=${OSTypes[$[$RANDOM%9]]}
OSType=\"${OSTypeStr}\"

OSCoreVersion=$[$RANDOM%9+1].$[$RANDOM%10]

OSDistributionName=\"${OSTypeStr}-${OSCoreVersion}\"

Keyword="\"API:${UpperLetters[$[$RANDOM%26]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}${AllLetters[$[$RANDOM%52]]}\""

Tags=null
StructedData=null

RunningEnvironment=\"${RunningEnvironments[$[$RANDOM%4]]}\"

logRecord="${CreateTime}|${EventLevel}|${LoggerName}|${EventCode}|{\"ProductId\":${ProductId},\"SchemaName\":${SchemaName},\"NodeId\":${NodeId},\"ServiceName\":${ServiceName},\"InstanceId\":${InstanceId},\"LoggerType\":${LoggerType},\"Message\":${Message}, \"CodeLanguage\":${CodeLanguage},\"CodePath\":${CodePath},\"StructedData\":${StructedData},\"ValueUnit\":${ValueUnit},\"Value\":${Value},\"HardwarePlatform\":${HardwarePlatform},\"OSType\":${OSType},\"OSCoreVersion\":${OSCoreVersion},\"OSDistributionName\":${OSDistributionName},\"Keyword\":${Keyword},\"Tags\":${Tags},\"RunningEnvironment\":${RunningEnvironment}}"

echo $index
#echo $logRecord
#exit 0 
echo "$logRecord" >> /install/test/mylogger.log
sleep 0.1s
done
