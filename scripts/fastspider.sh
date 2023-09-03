#!/bin/bash

report_path="/home/kali/resources/reports"

# Function to perform OSINT based on the user's choice
perform_osint() {
    case $1 in
        "name")
            echo "Performing OSINT for a name..."
            # Add your name-related OSINT commands here
            spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)
            ;;
        "username")
            echo "Performing OSINT for a username..."
            # Add your username-related OSINT commands here
            spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)
            ;;
        "email")
            echo "Performing OSINT for an email..."
            # Add your email-related OSINT commands here
            spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)
            ;;
        "ip")
            echo "Performing OSINT for an IP..."
            # Add your IP-related OSINT commands here
            spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)
            ;;
        "domain")
            echo "Performing OSINT for a domain..."
            # Add your domain-related OSINT commands here
            spiderfoot -q -u all -s $OSINT_TARGET | tee -a $report_path/Spiderfoot_Scan-$OSINT_TARGET-$(date +%Y_%m_%d)
            ;;
        *)
            echo "Invalid option. Please choose a valid option: name, username, email, ip, or domain."
            ;;
    esac
}

# Prompt the user for their choice
echo "Select an OSINT option:"
echo "1. Name (use single quotes)"
echo "2. Username"
echo "3. Email"
echo "4. IP"
echo "5. Domain"
read -p "Enter your choice (1/2/3/4/5): " choice

# Map the user's choice to the respective option
case $choice in
    1)
        perform_osint "name"
        ;;
    2)
        perform_osint "username"
        ;;
    3)
        perform_osint "email"
        ;;
    4)
        perform_osint "ip"
        ;;
    5)
        perform_osint "domain"
        ;;
    *)
        echo "Invalid choice. Please enter a valid option."
        ;;
esac





read -p "Who is the target? (name between single quotes, username, e-mail, ip, domain) " OSINT_TARGET
