# Azure DevOps Agent

Ansible role to download, install, and configure Azure DevOps self-hosted agent.

## Features

- Download and install Azure DevOps self-hosted agent
  * Currently supported platforms: Linux x86_64
- Configure Azure DevOps self-hosted agent
- Start Azure DevOps self-hosted agent
- Stop Azure DevOps self-hosted agent
- Uninstall Azure DevOps self-hosted agent
- Update Azure DevOps self-hosted agent
- Update Azure DevOps self-hosted agent token

## Requirements

- Ansible

## Role Variables

```yaml
# Azure DevOps organization name

organization_name: "Innovaox"

# Azure DevOps organization URL

organization_url: "https://dev.azure.com/{{ organization_name }}"

# Azure DevOps Agent Version

agent_version: "3.241.0"

# Azure DevOps agent name

agent_name: "agent"

# Azure DevOps agent token

agent_token: "agent-token"

# Azure DevOps agent work directory

agent_work_directory: "_work"

# Azure DevOps agent user

agent_user: "azagent"

# Azure DevOps agent installation directory

agent_installation_directory: "/home/{{ agent_user }}/azagent"

# Azure DevOps agent download URL

agent_download_url: "https://vstsagentpackage.azureedge.net/agent/{{ agent_version }}/vsts-agent-linux-x64-{{ agent_version }}.tar.gz"

# Azure DevOps Deployment Group name

agent_deployment_group_name: "deployment-group"

# Azure DevOps Deployment Group project name

agent_deployment_group_project_name: "deployment-group-project"
```

## Dependencies

None

## Installation

```bash
ansible-galaxy install farisc0de.azdevopsagent
```

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: farisc0de/azdevopsagent
      vars:
        organization_name: "Innovaox"
        agent_name: "agent"
        agent_user: "azagent"
        agent_token: "agent-token"
        agent_work_directory: "_work"
        agent_user: "agent-user"
        agent_installation_directory: "/home/{{ agent_user }}/azure-devops-agent"
        agent_version: "3.241.0"
        agent_deployment_group_name: "deployment-group"
        agent_deployment_group_project_name: "deployment-group-project"
        agent_download_url: "{{ agent_download_url }}"
        organization_url: "{{ organization_url }}"
```

## License

MIT
