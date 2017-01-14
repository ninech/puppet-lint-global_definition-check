Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-global_resource-check'
  spec.version     = '0.3.1'
  spec.homepage    = 'https://github.com/ninech/puppet-lint-global_resource-check'
  spec.license     = 'MIT'
  spec.author      = 'Marius Rieder'
  spec.email       = 'marius.rieder@nine.ch'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint global_resource check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that your manifests have no global resources.
  EOF

  spec.add_dependency             'puppet-lint', '~> 2.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end

