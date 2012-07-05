$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "deployd/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "deployd"
  s.version     = Deployd::VERSION
  s.authors     = ["Thomas Dippel"]
  s.email       = ["thomas@dippel.dk"]
  s.homepage    = "http://www.dipth.com"
  s.summary     = "A Rails Engine that lists your recent Engineyard Deploys"
  s.description = "A Rails Engine that lists your recent Engineyard Deploys"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "3.1.6"
  s.add_dependency "grit", "~> 2.5"

  # s.add_development_dependency "sqlite3"
end
