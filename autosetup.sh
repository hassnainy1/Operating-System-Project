#!/bin/sh



# Ask for project folder name

echo "Enter the name of your project folder:"

read PROJECT_DIR



# Create main project folder and subfolders

mkdir -p "$PROJECT_DIR/reports"

mkdir -p "$PROJECT_DIR/backups"



# Ask for the content to write into the report file

echo "Enter the content you want to write into the report file:"

read REPORT_CONTENT



# Create the report file with user content and current date

echo "$REPORT_CONTENT" > "$PROJECT_DIR/reports/report.txt"

echo "Generated on: $(date)" >> "$PROJECT_DIR/reports/report.txt"



# Copy the file to backups/

cp "$PROJECT_DIR/reports/report.txt" "$PROJECT_DIR/backups/"



# Final message

echo "Folders and file created successfully in '$PROJECT_DIR'."


