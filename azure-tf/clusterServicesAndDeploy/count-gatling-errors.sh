#!/bin/bash
input_file=$1
line_num=$(wc -l < $input_file)
global_message=""

while read line; do
    ((line_num--))
    if [[ "$line" == *"Global Information"* ]]; then
        global_line=$(($line_num + 1))
        break
    fi
done < <(tac $input_file)

failed_triggered=0

while read line; do
    if [[ $line == *"=="* ]]; then
        break
    fi
    global_message+="$line"
    global_message+='\n'
    if [[ $line == *"failed"* ]] && [[ $failed_triggered -eq 0 ]]; then
        # grab the percentage with regex
        read -ra line_arr <<< $line
        last_index=$((${#line_arr[@]} - 1))
        failure_string=${line_arr[$last_index]//[^[:digit:]]/}
        echo "Error String: $failure_string"
        failure_percentage=$((failure_string))
        failed_triggered=1
    fi
done < <(tail -n +$global_line $input_file)

if [[ $failure_percentage -eq 0 ]]; then
    echo -e "No Errors Found. Generating Report:\n"
else
    echo -e "Errors Found, Sending Report to SNS. Generating Report:\n"
    payload='{"message": "'
    payload+="$global_message"
    payload+='"}'
    aws lambda invoke --function-name terraformStocktraderLooprNotifier --cli-binary-format raw-in-base64-out --payload "$payload" report.json
fi

echo -e "$global_message"
