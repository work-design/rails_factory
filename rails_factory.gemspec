$:.push File.expand_path('lib', __dir__)
require 'rails_factory/version'

Gem::Specification.new do |s|
  s.name = 'rails_factory'
  s.version = RailsFactory::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/yougexiangfa/rails_factory'
  s.summary = 'Data Import & Export for Rails'
  s.description = 'Description of TheData.'
  s.license = 'LGPL-3.0'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '>= 5.0'
  s.add_dependency 'rails_com'
  s.add_dependency 'rails_taxon'
end
