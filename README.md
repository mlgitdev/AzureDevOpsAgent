# Azure DevOps Agent

Ansible role to download, install, and configure Azure DevOps self-hosted agent.

## Features

- Download and install Azure DevOps self-hosted agent
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
# Azure DevOps organization URL
organization_url: "https://dev.azure.com/organization"

# Azure DevOps project name

project_name: "project"

# Azure DevOps agent pool name

agent_pool_name: "Default"

# Azure DevOps agent name

agent_name: "agent"

# Azure DevOps agent token

agent_token: "agent-token"

# Azure DevOps agent work directory

agent_work_directory: "_work"

# Azure DevOps agent installation directory

agent_installation_directory: "/opt/azure-devops-agent"

# Azure DevOps agent version

agent_version: "2.186.1"

# Azure DevOps agent download URL

agent_download_url: "https://vstsagentpackage.azureedge.net/agent/{{ agent_version }}/vsts-agent-linux-x64-{{ agent_version }}.tar.gz"

# Azure DevOps Deployment Group name

agent_deployment_group_name: "deployment-group"

# Azure DevOps Deployment Group project name

agent_deployment_group_project_name: "deployment-group-project"
```

## Dependencies

None

## Example Playbook

```yaml
- hosts: localhost
  roles:
    - role: ansible-role-azure-devops-agent
      vars:
        organization_url: "https://dev.azure.com/organization"
        project_name: "project"
        agent_pool_name: "Default"
        agent_name: "agent"
        agent_token: "agent-token"
        agent_work_directory: "_work"
        agent_installation_directory: "/opt/azure-devops-agent"
        agent_version: "2.186.1"
        agent_download_url: "https://vstsagentpackage.azureedge.net/agent/{{ agent_version }}/vsts-agent-linux-x64-{{ agent_version }}.tar.gz"
        agent_deployment_group_name: "deployment-group"
        agenet_deployment_group_project_name: "deployment-group-project"
```

## License

MIT
