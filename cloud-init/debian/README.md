# Cloud-Init Configuration

This folder contains configuration files and scripts for provisioning ephemeral compute instances using **cloud-init**.
Provisioning such instances is helpful for testing for repeatability and isolation for cloud-based and machine learning workflows.  This can also be used to provision cloud-based development environments.  

## Overview

Cloud-init is a widely used tool for initializing cloud instances during the first boot. It allows you to configure instances, install packages, and run custom scripts.

This folder includes:
- YAML configuration files for cloud-init.
- Custom scripts for instance configuration.
- Templates for user data and metadata.

## Folder Structure

```
cloud-init/
├── user-data.yaml       # Main cloud-init configuration file
├── meta-data.yaml       # Metadata for the instance
├── cloud-init.sh        # provisions the ephemeral environment
├── teardown.sh          # destroys the ephemeral environment
├── user-init.sh         # called by cloud-init on the guest OS
└── README.md            # Documentation
```

## Why not just use Docker?
Docker still needs a place to run.  This is about creating a standard guest VM.  This release focuses on user-facing configuration.  This may be needed for automating the setup of a GPU server for machine learning, establishing a remote debugging environment, or test automation.

A future release will handle automating the server-side configuration, such as GPU support, Docker, and Kubernetes.  

## Usage

1. **Install Prerequisites on Host**
   Dependencies include virt-install, cloud-image-utils, and cloud-init
2. **Prepare Cloud-Init Files**  
   Edit the `user-data.yaml` and `meta-data.yaml` files as needed.  Customize the paths and images inside `cloud-init.sh`.
3. **Run Cloud-Init**  
   Use the following command to apply the configuration when launching an instance:
   ```bash
   ./cloud-init.sh
   ```

## Notes

- Ensure the `user-data.yaml` file is properly formatted as YAML.
- Test configurations in a staging environment before applying them to production instances.

## References

- [Cloud-Init Documentation](https://cloud-init.io/)
- [YAML Syntax Guide](https://yaml.org/)