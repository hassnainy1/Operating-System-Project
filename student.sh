#!/bin/bash

DATA_FILE="students.txt"

add_student(){
    echo "Student name:"
    read name

    while true; do
        echo "Enter Roll Number:"
        read roll

        if grep -q "^$roll|" "$DATA_FILE"; then
            echo "Roll Number already exists. Please enter a unique roll number."
        else
            break
        fi
    done

    echo "Enter marks for Subject 1:"
    read sub1
    echo "Enter marks for Subject 2:"
    read sub2
    echo "Enter marks for Subject 3:"
    read sub3

    avg=$(( (sub1 + sub2 + sub3) / 3 ))

    if [ $avg -ge 90 ]; then
        grade="A"
    elif [ $avg -ge 80 ]; then
        grade="B"
    elif [ $avg -ge 70 ]; then
        grade="C"
    elif [ $avg -ge 60 ]; then
        grade="D"
    else
        grade="F"
    fi

    echo "$roll|$name|$sub1|$sub2|$sub3|$avg|$grade" >> "$DATA_FILE"
    echo "Student added successfully! Average: $avg, Grade: $grade"
}

update_student(){
    echo "Enter Roll Number to update:"
    read roll

    if grep -q "^$roll|" "$DATA_FILE"; then
        echo "Enter new name:"
        read name
        echo "Enter new marks for Subject 1:"
        read sub1
        echo "Enter new marks for Subject 2:"
        read sub2
        echo "Enter new marks for Subject 3:"
        read sub3

        avg=$(( (sub1 + sub2 + sub3) / 3 ))

        if [ $avg -ge 90 ]; then
            grade="A"
        elif [ $avg -ge 80 ]; then
            grade="B"
        elif [ $avg -ge 70 ]; then
            grade="C"
        elif [ $avg -ge 60 ]; then
            grade="D"
        else
            grade="F"
        fi

        sed -i "/^$roll|/d" "$DATA_FILE"
        echo "$roll|$name|$sub1|$sub2|$sub3|$avg|$grade" >> "$DATA_FILE"
        echo "Student updated successfully!"
    else
        echo "Student not found."
    fi
}

view_all(){
    echo -e "Roll\tName\tS1\tS2\tS3\tAvg\tGrade"
    echo "----------------------------------------------------------"
    while IFS="|" read -r roll name s1 s2 s3 avg grade; do
        echo -e "$roll\t$name\t$s1\t$s2\t$s3\t$avg\t$grade"
    done < "$DATA_FILE"
}

search_student(){
    echo "Enter Roll Number or Name to Search:"
    read keyword

    result=$(grep -i "$keyword" "$DATA_FILE")

    if [ -n "$result" ]; then
        echo "Found:"
        echo "Roll|Name|Subject1|Subject2|Subject3|Average|Grade"
        echo "$result"
    else
        echo "No matching student found."
    fi
}

delete_student(){
    echo "Enter Roll Number to delete:"
    read roll

    if grep -q "^$roll|" "$DATA_FILE"; then
        sed -i "/^$roll|/d" "$DATA_FILE"
        echo "Student deleted successfully."
    else
        echo "Student not found."
    fi
}

clear_data(){
    echo "Are you sure you want to delete all data? (Y/N)"
    read confirm

    if [[ "$confirm" == "Y" || "$confirm" == "y" ]]; then
        > "$DATA_FILE"
        echo "All records deleted."
    else
        echo "Operation cancelled."
    fi
}

menu(){
    while true; do
        echo ""
        echo "===== Student Record Management ====="
        echo "1. Add Student"
        echo "2. Update Student"
        echo "3. View All Students"
        echo "4. Search Student"
        echo "5. Delete Student"
        echo "6. Clear All Records"
        echo "7. Exit"
        echo "Enter your choice: "
        read choice

        case $choice in
            1) add_student ;;
            2) update_student ;;
            3) view_all ;;
            4) search_student ;;
            5) delete_student ;;
            6) clear_data ;;
            7) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option. Try again." ;;
        esac
    done
}

# Ensure the data file exists
touch "$DATA_FILE"

# Start the menu
menu
