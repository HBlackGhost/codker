#! /bin/bash
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
RESET='\e[0m'
CYAN='\e[36m'
MAGENTA="\e[35m"
BOLD='\e[1m'
banner()
{
    x=$(echo -e $RED"Codker :${BLUE}-->${GREEN} Coded By Ahmed Alaa Ghazala ${YELLOW}[HBG]")
    banner="\
    `echo -e $BOLD$CYAN`

    ▄████▄   ▒█████  ▓█████▄  ██ ▄█▀▓█████  ██▀███  
    ▒██▀ ▀█  ▒██▒  ██▒▒██▀ ██▌ ██▄█▒ ▓█   ▀ ▓██ ▒ ██▒
    ▒▓█    ▄ ▒██░  ██▒░██   █▌▓███▄░ ▒███   ▓██ ░▄█ ▒
    ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▓██ █▄ ▒▓█  ▄ ▒██▀▀█▄  
    ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ▒██▒ █▄░▒████▒░██▓ ▒██▒
    ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ▒ ▒▒ ▓▒░░ ▒░ ░░ ▒▓ ░▒▓░
    ░  ▒     ░ ▒ ▒░  ░ ▒  ▒ ░ ░▒ ▒░ ░ ░  ░  ░▒ ░ ▒░
    ░        ░ ░ ░ ▒   ░ ░  ░ ░ ░░ ░    ░     ░░   ░ 
    ░ ░          ░ ░     ░    ░  ░      ░  ░   ░     
    ░                  ░                              
                    
                        $x
    "
    term_width=$(tput cols)
    while IFS= read -r line; do
        line_length=${#line}
        padding=$(( (term_width - line_length) / 2 ))
        printf "%${padding}s%s\n" "" "$line"
    done <<< "$banner"
}
usage_menu() {
    echo -e "${CYAN}Usage: ./codker.sh [OPTIONS]${RESET}"
    echo -e "${YELLOW}A script for checking HTTP status codes of domain lists.${RESET}"
    echo ""
    echo -e "${GREEN}Options:${RESET}"
    echo -e "  -h    Show this help message and exit"
    echo -e "  -l    Specify the file containing the list of URLs to check"
    echo -e "  -o    Specify the output file for results (requires -l option)"
    echo ""
    echo -e "${CYAN}Example:${RESET}"
    echo -e "  ./codker.sh -l domain.txt -o results.txt"
    echo ""
    echo -e "${GREEN}Notes:${RESET}"
    echo -e "  - The file specified with the -l option should contain one URL per line."
    echo -e "  - URLs should be in a format like 'example.com' (without 'https://')."
    echo -e "  - The -o option is dependent on the -l option being specified first."
    echo ""
}
code_checker() {
    echo -e $RESET
    total_urls=$(wc -l < "$list")
    counter=0
    up_domains=0  
    down_domains=0
    echo -e $BOLD$YELLOW"Starting:"
    while IFS= read -r line; do
        ((counter++))
        code=$(curl -I -s -o /dev/null --connect-timeout 5 -w "%{http_code}" "http://$line")
        if [[ "$code" -ge 200 && "$code" -lt 400 ]]; then
            ((up_domains++))
            domain_percentage=$((up_domains * 100 / total_urls))
            printf "${BOLD}${GREEN}[-] $line$RED --> [$code] %-30s \n"
            up_domains+=("$line")
        else
            ((down_domains++))
        fi
        percentage=$((counter * 100 / total_urls))
        remaining=$((total_urls - counter))
        printf "${CYAN}Processing: $RED%-0d%% $RESET$BOLD$CYAN[${remaining} remaining]\r" "$percentage"
        
    done < "$list"
    printf "$BOLD${GREEN}[Up Domains: $up_domains] ${RED}[Down Domains: $down_domains] ${CYAN}[Total : $total_urls]\n"
}
while getopts "loh" opt ;
do 
case $opt in
       l)   
            
            if [[ -z $2 ]];then
                echo -e "$BOLD${RED}[!] Error:${GREEN} You must choose ${RED}domains file ${RESET}"
                exit 1
            elif [[ -e $2 ]]; then
                list=$2
                banner
                code_checker
                if [[ -z $4 ]];
                then
                    echo -e "$BOLD${RED}[!] Error:${GREEN} You must choose a ${RED}file${GREEN} to output in it.${RESET}"
                    exit 1
                else
                    for i in "${up_domains[@]:1}" ;do
                        echo "$i" >> $4
                    done
                    echo -e "$BOLD${YELLOW}[-]$GREEN Saving results to file: $4"

                fi
                
            else
                echo -e "$BOLD${RED}[!] Error:${GREEN} The file $YELLOW$2$GREEN does not exist.${RESET}"
                exit 1
            fi
            ;;

        h)
            banner
            usage_menu
            exit 1
         ;;
    
esac
done

