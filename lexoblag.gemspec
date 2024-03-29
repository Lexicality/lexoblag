# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "lexoblag"
  spec.version       = "0.1.0"
  spec.authors       = ["Lexi Robinson"]
  spec.email         = ["lex@lex.me.uk"]

  spec.summary       = "Lexi's Website/blog theme"
  spec.homepage      = "https://github.com/Lexicality/lexoblag"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README)!i) }

  spec.add_runtime_dependency "jekyll", "~> 3.8"
end
