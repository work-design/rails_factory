ENV['RAILS_ENV'] = 'test'
require_relative '../test/dummy/config/environment'
require 'rails/test_help'
require 'minitest/mock'

ActiveRecord::Migrator.migrations_paths = [File.expand_path('../test/dummy/db/migrate', __dir__)]
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

if defined?(FactoryBot)
  FactoryBot.definition_file_paths << File.expand_path('factories', __dir__)
end

class ActiveSupport::TestCase
  self.file_fixture_path = File.expand_path('fixtures/files', __dir__)
  include FactoryBot::Syntax::Methods if defined?(FactoryBot)
end
