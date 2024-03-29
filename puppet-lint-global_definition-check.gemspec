Gem::Specification.new do |spec|
  spec.name = "puppet-lint-global_definition-check"
  spec.version = ENV.fetch("CI_COMMIT_TAG", "v0.0.1").delete_prefix("v")
  spec.homepage = "https://github.com/ninech/puppet-lint-global_definition-check"
  spec.license = "MIT"
  spec.author = "Nine Internet Solutions AG"
  spec.email = "support@nine.ch"
  spec.files = Dir[
    "README.md",
    "LICENSE",
    "lib/**/*",
    "spec/**/*",
  ]
  spec.summary = "puppet-lint checks for global definions"
  spec.description = <<-EOF
    Extends puppet-lint to ensure that your manifests have no global resources.
  EOF

  spec.add_dependency "puppet-lint", ">= 2.2", "< 5"
  spec.add_development_dependency "rspec", "~> 3.4"
  spec.add_development_dependency "rspec-its", "~> 1.3"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.2"
  spec.add_development_dependency "rspec-json_expectations"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "standardrb"
  spec.add_development_dependency "simplecov-console"
end
