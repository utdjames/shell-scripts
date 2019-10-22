#!/bin/bash
echo "New licenses:" 
now=$(date +%s); curl -s https://abc.utah.gov/license/documents/new_licenses.pdf -o /var/tmp/liq_${now}.pdf && pdfgrep -i "${1}" /var/tmp/liq_${now}.pdf && rm -f /var/tmp/liq_*.pdf
echo ""
echo "Existing licenses:" 
now=$(date +%s); curl -s https://abc.utah.gov/license/documents/licensee_list.pdf -o /var/tmp/liq_${now}.pdf && pdfgrep -i "${1}" /var/tmp/liq_${now}.pdf && rm -f /var/tmp/liq_*.pdf
