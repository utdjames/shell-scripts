#!/bin/bash

# Check if required commands are available
command -v curl >/dev/null 2>&1 || { echo >&2 "curl not found. Aborting."; exit 1; }
command -v pdftotext >/dev/null 2>&1 || { echo >&2 "pdftotext not found. Aborting."; exit 1; }
command -v grep >/dev/null 2>&1 || { echo >&2 "grep not found. Aborting."; exit 1; }

# Check if input argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <search term>"
    exit 1
fi

# Download new licenses PDF file
curl -s https://abs.utah.gov/wp-content/uploads/new_licenses.pdf -o new_licenses.pdf
if [ $? -ne 0 ]; then
    echo "Failed to download new licenses PDF file. Aborting."
    exit 1
fi

# Convert new licenses PDF to text file
pdftotext -layout new_licenses.pdf
if [ $? -ne 0 ]; then
    echo "Failed to convert new licenses PDF to text. Aborting."
    rm -f new_licenses.pdf
    exit 1
fi

# Search for search term in new licenses text file
echo ""
echo ""
echo "New licenses:"
grep -i "$1" new_licenses.txt | grep -v ^OP

# Clean up new licenses files
rm -f new_licenses.pdf
rm -f new_licenses.txt

# Download existing licenses PDF file
curl -s https://abs.utah.gov/wp-content/uploads/licensee_list.pdf -o licensee_list.pdf
if [ $? -ne 0 ]; then
    echo "Failed to download existing licenses PDF file. Aborting."
    exit 1
fi

# Convert existing licenses PDF to text file
pdftotext -layout licensee_list.pdf
if [ $? -ne 0 ]; then
    echo "Failed to convert existing licenses PDF to text. Aborting."
    rm -f licensee_list.pdf
    exit 1
fi

# Search for search term in existing licenses text file
echo ""
echo ""
echo "Existing licenses:"
grep -i "$1" licensee_list.txt | grep -v ^OP

# Clean up existing licenses files
rm -f licensee_list.pdf
rm -f licensee_list.txt
