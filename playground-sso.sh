# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias dcup="docker-compose up" 
alias dcdown="docker-compose down" 
alias dcps="docker-compose ps" 
alias dclogs="docker-compose logs" 
alias dc="docker-compose" 
alias dcstop="docker-compose stop" 
alias dcrm="docker-compose rm" 
alias rs="reset" 


# Source global definitions
if [ -f /etc/bashrc ]; then
 . /etc/bashrc
fi
export PATH=$PATH:/usr/local/bin
export TERM=xterm-256color
export COLORTERM=xterm-256color
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ~/.bashrc

export ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3

disable_ctrl_c() {
    stty intr ''
}

disable_ctrl_c


profiles=("playground")
account_signin() {


# Display menu and prompt user for selection
echo "Select a profile:"
for ((i=0; i<${#profiles[@]}; i++)); do
    echo "$((i+1)). ${profiles[i]}"
done

read -ep "Enter the profile number: " selected_profile_number
printf "\n"

# Validate user input
if ! [[ "$selected_profile_number" =~ ^[1-9]|10$ && "$selected_profile_number" -le "${#profiles[@]}" ]]; then
    echo "Invalid selection."
    exit 1
fi

# Get the selected profile
selected_profile=${profiles[selected_profile_number-1]}

# Execute aws sso login command
aws sso login --profile "$selected_profile"

}

update_kubeconfig() {


    # List available EKS clusters
    echo "Listing available EKS clusters..."
    clusters=($(aws eks --profile "$selected_profile" list-clusters --region ap-southeast-1 | jq -r '.clusters[]'))

    # Display menu for selecting EKS cluster
    echo "Select an EKS cluster:"
    for ((i=0; i<${#clusters[@]}; i++)); do
        echo "$((i+1)). ${clusters[i]}"
    done

    read -ep "Enter the cluster number: " selected_cluster_number
    printf "\n"


    # Validate user input
    if ! [[ "$selected_cluster_number" =~ ^[1-9]|10$ && "$selected_cluster_number" -le "${#clusters[@]}" ]]; then
        echo "Invalid selection."
        exit 1
    fi

    # Get the selected cluster
    selected_cluster=${clusters[selected_cluster_number-1]}

    # Update kubeconfig for the selected cluster
    aws eks update-kubeconfig --profile "$selected_profile" --region ap-southeast-1 --name "$selected_cluster"

}



account_signin
update_kubeconfig
