#!/bin/bash
userid=$(id -u)


FOLDER_PATH="/var/log/disk_space"
mkdir -p $FOLDER_PATH
SCRIPT_NAME=$(echo $0 | awk -F "." '{print $1F}')
TIMESTAMP=$(date +%Y-%h-%m-%H-%M-%S)
LOG_FILE="$FOLDER_PATH/$SCRIPT_NAME/$TIMESTAMP-app.log"

echo $LOG_FILE


USER(){
    if [ ${userid} -ne 0 ]
    then
        echo "As you didnt have root access, pls run scripts with root access to proceed further."
        exit 1
    else
        echo "Hurray! You are having root access, hence proceeding further."
    fi

}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "are FAILED"
    else
        echo "are SUCCESS"
    fi
}




USER

DISK_FILES=$(df -hT | grep xfs)
Threshold=50

while IFS= read -r line
do
DISK_USED=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1)
MOUNTED_ON=$(echo $line | awk -F " " '{print $NF}')
if [ ${DISK_USED} -gt ${Threshold} ]
then
    echo "Below files are execeed the disk usage more than threshold percentage, $DISK_USED" &>>$LOG_FILE
    echo "Those filesystems mounted on ${MOUNTED_ON}" | tee -a $LOG_FILE
    VALIDATE $? "Extraction of filesystems" 
else
    echo "Dont have any files which exceed the ${Threshold}" &>>$LOG_FILE
fi


done <<< $DISK_FILES

