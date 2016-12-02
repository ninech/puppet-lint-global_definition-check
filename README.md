# puppet-lint global resource check

## Installation

To use this plugin, add the following like to the Gemfile in your Puppet code
base and run `bundle install`.

```ruby
gem 'puppet-lint-global_resource-check', '~> '0.3.0'
```

For puppet-lint version 1.1

```ruby
gem 'puppet-lint-global_resource-check', '~> '0.2.0'
```

## Usage

This plugin provides a new check to `puppet-lint`.

### global_resource

**--fix support: No**

This check will raise a error for any global defines resource.

```
ERROR: Resource file in global space on line 19
```

