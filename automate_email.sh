#!/bin/bash
#get line count
# Change mycsv to your file name
linecount=$(cat mycsv.csv  | wc -l)
#set counting variable
counter=1
#loop through file
while read line; do
    #split each line into an array by comma
    IFS=, read -a arr <<< "$line";
    #set  array values to variables
    #Change subject as per your requirement
    subject="Immediate action is required! CS550: Credentials for your CSVB VM";
    user="${arr[0]}";
    ip="${arr[2]}";
    password="${arr[3]}";
    access="https://docs.google.com/document/d/1AcDf1_yBVu-Vf313_TxK1bwJB78VYFjk44utHtd_GB4/edit"
    misc="You must change your password immediately using \$passwd command"
    #create body
    body=$(printf " User: %s \n IP address: %s \n password: %s \n Access Instructions: %s \n %s" "$user" "$ip" "$password" "$access" "$misc")
    #echo progress
    echo "Sending email $counter of $linecount: User $user"
    #send email
    echo "$body" | mail -s "$subject" -a FROM:name@domain.edu $user@domain.edu #change the from and to address
    #advance counter
    counter=$(( $counter +1 ))
    #sleep for a second
    sleep 5
done < mycsv.csv