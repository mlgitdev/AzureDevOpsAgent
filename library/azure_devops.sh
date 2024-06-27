#!/bin/bash

source $1

# Check if the installed version is the same as the version in the inventory

function check_version {
    cd $agent_installation_directory
    
    installed_version=$(./bin/Agent.Listener --version)
    
    if [ "$installed_version" == "$agent_version" ]; then
        changed=false
        msg="Azure DevOps Agent is already installed"
        
        print_status "$changed" "$msg"
        
        exit 0
    fi
}

# Download the Azure DevOps Agent

function download_agent {
    if [ ! -d "$agent_installation_directory" ]; then
        mkdir -p $agent_installation_directory
    fi
    
    cd $agent_installation_directory
    
    curl -fkSL -o vsts-agent-linux-x64.tar.gz $agent_download_url
    
    tar -zxvf vsts-agent-linux-x64.tar.gz
    
    #check if the agent failed to download
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to download Azure DevOps Agent"
        print_error "$failed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent downloaded successfully"
    
    print_status "$changed" "$msg"
    
}

# Install the Azure DevOps Agent

function install_agent {
    cd $agent_installation_directory
    
    if( -z "$agent_work_directory" )
    then
        agent_work_directory="_work"
    fi
    
    if( -z "$agent_name" )
    then
        agent_name=$(hostname)
    fi
    
    ./config.sh --unattended --url $orgnization_url --auth pat --token $agent_token --pool $agent_pool_name --agent $agent_name --work $ --deploymentgroup --deploymentgroupname "$agent_deployment_group_name" --projectname "$agent_deployment_group_project_name" --runasservice --acceptTeeEula
    
    #check if the agent failed to install
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to install Azure DevOps Agent"
        print_error "$failed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent installed successfully"
    
    print_status "$changed" "$msg"
    
}

# Start the Azure DevOps Agent

function start_agent {
    cd $agent_installation_directory
    
    ./svc.sh install
    ./svc.sh start
    
    #check if the agent failed to start
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to start Azure DevOps Agent"
        print_error "$failed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent started successfully"
    
    print_status "$changed" "$msg"
}

# Stop the Azure DevOps Agent

function stop_agent {
    cd $agent_installation_directory
    
    ./svc.sh stop
    
    #check if the agent failed to stop
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to stop Azure DevOps Agent"
        print_error "$failed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent stopped successfully"
    
    print_status "$changed" "$msg"
}

# Uninstall the Azure DevOps Agent

function uninstall_agent {
    cd $agent_installation_directory
    
    ./svc.sh stop
    ./svc.sh uninstall
    
    rm -rf $agent_installation_directory
    
    #check if the agent failed to uninstall
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to uninstall Azure DevOps Agent"
        print_error "$failed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent uninstalled successfully"
    
    print_status "$changed" "$msg"
}

# Update the Azure DevOps Agent PAT token

function update_token {
    cd $agent_installation_directory
    
    ./config.sh remove --auth pat
    
    ./config.sh --unattended --url $orgnization_url --auth pat --token $agent_token --pool $agent_pool_name --agent $agent_name --work $agent_work_directory --deploymentgroup --deploymentgroupname "$agent_deployment_group_name" --projectname "$agent_deployment_group_project_name" --runasservice --acceptTeeEula
    
    #check if the agent failed to update
    
    if [ $? -ne 0 ]; then
        failed=true
        msg="Failed to update Azure DevOps Agent PAT token"
        print_error "$changed" "$msg"
        exit 1
    fi
    
    changed=true
    msg="Azure DevOps Agent PAT token updated successfully"
    
    print_status "$changed" "$msg"
}

function print_error {
    printf '{"failed": %s, "msg": "%s"}' "$1" "$2"
}

function print_status() {
    printf '{"changed": %s, "msg": "%s"}' "$1" "$2"
}


case $action in
    check_version)
        check_version
    ;;
    download)
        download_agent
    ;;
    install)
        install_agent
    ;;
    start)
        start_agent
    ;;
    stop)
        stop_agent
    ;;
    uninstall)
        uninstall_agent
    ;;
    update)
        update_token
    ;;
    *)
        changed=true
        msg="Invalid action"
        print_error "$changed" "$msg"
    ;;
esac

exit 0