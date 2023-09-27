# puppet-lint global definition check

[![rspec](https://github.com/ninech/puppet-lint-global_definition-check/actions/workflows/rspec.yml/badge.svg)](https://github.com/ninech/puppet-lint-global_definition-check/actions/workflows/rspec.yml)
[![Gem Version](https://badge.fury.io/rb/puppet-lint-global_definition-check.svg)](https://badge.fury.io/rb/puppet-lint-global_definition-check)

## Installation

To use this plugin, add the following like to the Gemfile in your Puppet code
base and run `bundle install`.

```ruby
gem "puppet-lint-global_definition-check"
```

## Usage

This plugin provides a new check to `puppet-lint`.

### global_resource

**--fix support: No**

This check will raise a error for any global resource.

```
ERROR: resource file in global space on line 19
```

### global_function

**--fix support: No**

This check will raise a error for any global function.

```
ERROR: token ensure_resouce in global space on line 19
```


