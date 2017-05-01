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

Just a very simple module to convert a role fact `role` into a `safe_role` fact by converting any colons in the value into underscores.  This lets us write `hiera.yaml` files that look like this:

```yaml
:hierarchy:
  - "nodes/%{clientcert}"
  - "roles/%{safe_role}"
  - "app_tier/%{app_tier}"
  - "datacenter/%{datacenter}"
  - "env/%{environment}"
  - common
```

...So that for a role class `foo::bar::baz` we attempt to read `foo__bar__baz.yaml`.  Of course `::` in filenames is a terrible idea but it works at a push on Linux.  For those not living the dream, using this character in filenames will result in git repositories that are impossible to checkout from git.

## Setup
Just install the module and if the a facter fact called `role` is detected it will be sanitised and made availabe in `safe_role`

## Limitations

* Doesn't process `pp_role` (trusted fact) yet.  I may add this if I get a chance

## Development

* Feel free to PR
