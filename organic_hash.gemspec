require './lib/organic_hash'

Gem::Specification.new do |s|
  s.name = "organic_hash"
  s.version = OrganicHash::VERSION

  s.authors = ["Joseph Chee Chang", "Zero Cho"]
  s.email = ["josephcc.cmu@gmail.com", "itszero@gmail.com"]
  s.license = 'Apache License, Version 2.0'

  s.summary = ""
  s.description = ""
  s.homepage = "https://github.com/josephcc/organic_hash"

  s.extra_rdoc_files = [
    "README.md"
  ]

  s.files         = `git ls-files`.split($/).reject { |path|
    (path.start_with? "data/") or (path.start_with? "parser/")
  } + Dir.glob("data/*.dat")
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end
