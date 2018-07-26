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

* A role fact `role` into a `safe_role` 
* A trusted fact role `pp_role` into `safe_pp_role`

The conversion process is to convert double colons (`::`) into slashes (`/`).

This lets us write `hiera.yaml` files that look like this:

```yaml
:hierarchy:
  - "node/%{clientcert}".yaml
  - "%{safe_role}".yaml
  - "app_tier/%{app_tier}".yaml
  - "datacenter/%{datacenter}".yaml
  - "env/%{environment}".yaml
  - common.yaml
```

...So that for a node that has a `role` or `pp_role` role value of `foo::bar::baz` will attempt to read hiera data from
`role/foo/bar/baz.yaml`.  Of course `::` in filenames is a terrible idea but it works at a push on Linux.  For those not
living the dream, using this character in filenames will result in git repositories that are impossible to checkout from
git, hence the need for this puppet module.

## Setup
Just install the module and the facts will be created if applicable

## Limitations
* TODO: windows support (powershell)
* Linux for support requires `openssl` and `awk` in the path

## Development

* Feel free to PR
