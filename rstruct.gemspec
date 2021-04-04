Gem::Specification.new do |spec|
  spec.name          = 'rstruct'
  spec.version       = '1.4'
  spec.summary       = %q(A cleaner, simpler version of Ruby Structs.)
  spec.authors       = ['Justin Bishop']
  spec.email         = ['jubishop@gmail.com']
  spec.homepage      = 'https://github.com/jubishop/rstruct'
  spec.license       = 'MIT'
  spec.files         = Dir['lib/**/*.rb'] + Dir['sig/**/*.rbs']
  spec.require_paths = ['lib']
  spec.bindir        = 'bin'
  spec.executables   = []
  spec.metadata      = {
    'source_code_uri' => 'https://github.com/jubishop/rstruct',
    'steep_types' => 'sig'
  }
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0')
  spec.add_runtime_dependency('core')
end
