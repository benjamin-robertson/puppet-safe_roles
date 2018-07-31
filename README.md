# safe_roles

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with safe_roles](#setup)
    * [What safe_roles affects](#what-safe_roles-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with safe_roles](#beginning-with-safe_roles)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

Just a very simple module to convert:

### roles
* A role fact `role` into a `safe_role` 
* A trusted fact role `pp_role` into `safe_pp_role`

The conversion process is to convert double colons (`::`) into slashes (`/`).

### os
* A normalised `safe_os` fact:
    * All values lowercased (eg: `RedHat` -> `redhat`)
    * All spaces removed from values (eg `2012 R2` -> `2012_r2`)

This lets us write `hiera.yaml` files that look like this:

```yaml
:hierarchy:
  - "node/%{clientcert}".yaml
  - "os/%{safe_role}".yaml
  - "app_tier/%{app_tier}".yaml
  - "datacenter/%{datacenter}".yaml
  - "env/%{environment}".yaml
  - "os/%{facts.safe_os.family}_%{facts.safe_os.release.major}.yaml"
  - common.yaml
```

This means that:
* A node that has a `role` or `pp_role` value of `foo::bar::baz` will attempt to read hiera data from
`role/foo/bar/baz.yaml` (instead of `role/foo::bar::baz.yaml`)
* A windows 2012 R2 node would attempt to read from `os/windows_2012_r2.yaml` (instead of `os/windows_2012 R2.yaml`)
* A RHEL 7 node would attempt to read read from `os/redhat_7.yaml` (instead of `os/RedHat_7.yaml`)

This resolves the problems that:
* `::` in filenames only works on linux
* Windows and MacOS have case insensitive filesystems which can result in broken git repositories when files are checked
    in accidentally that differ only by case
* Filenames need spaces when dealing with some Windows variants

## Setup
Just install the module and the facts will be created if applicable

## Limitations
* TODO: windows support for pp_role (powershell)
* Linux for support requires `openssl` and `awk` in the path

## Development

* Feel free to PR
