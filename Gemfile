source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '~> 5.2.0'
gem 'mysql2'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'sidekiq', '~> 5.1'
gem 'activejob-cancel'
gem 'whenever'

# assets
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'sass-rails'
gem 'sprockets', '4.0.0.beta7'

# views
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 4.0'
gem 'mini_magick', '~> 4.8'

# Utils
gem 'bcrypt'
gem 'kaminari', '~> 1.0.1'
#gem 'acts_as_list'
gem 'closure_tree', github: 'ClosureTree/closure_tree', ref: 'cb7363e'
gem 'httparty'
gem 'i18n', '1.0.1'
gem 'rqrcode'
gem 'jwt'

# engines
#gem 'rails_log', '2.1.1'
gem 'rails_com', github: 'qinmingyuan/rails_com'
gem 'rails_log', github: 'qinmingyuan/rails_log'
gem 'default_form', github: 'qinmingyuan/default_form'
gem 'the_auth', github: 'yigexiangfa/the_auth'
gem 'the_role', github: 'yigexiangfa/the_role'
gem 'the_data', github: 'yigexiangfa/the_data'
gem 'the_detail', github: 'yigexiangfa/the_detail'
gem 'the_notify', github: 'yigexiangfa/the_notify'
gem 'the_audit', github: 'yigexiangfa/the_audit'
#gem 'the_trade', github: 'yigexiangfa/the_trade'
gem 'the_sync', github: 'yigexiangfa/the_sync'
gem 'the_booking', github: 'yigexiangfa/the_booking'

# develop
#gem 'rails_com', path: '~/work/engine/rails_com'
#gem 'rails_log', path: '~/work/engine/rails_log'
#gem 'the_trade', path: '~/work/engine/the_trade'
#gem 'the_auth', path: '~/work/engine/the_auth'
#gem 'the_role', path: '~/work/engine/the_role'
#gem 'the_data', path: '~/work/engine/the_data'
#gem 'the_detail', path: '~/work/engine/the_detail'
#gem 'the_notify', path: '~/work/engine/the_notify'
gem 'the_trade', path: '~/work/engine/the_trade'
#gem 'the_audit', path: '~/work/engine/the_audit'
#gem 'the_sync', path: '~/work/engine/the_sync'
#gem 'the_taxon', path: '~/work/engine/the_taxon'

#gem 'default_form', path: '~/work/ruby/default_form'
gem 'default_where', path: '~/work/ruby/default_where'

gem 'awesome_print'
gem 'pry-rails'
gem 'server_timing'
gem 'scout_apm', '3.0.0.pre22'

group :development, :test do
  gem 'byebug'
  gem 'pry-stack_explorer'
  gem 'factory_bot_rails'
  gem 'mailcatcher' # mock email
end

group :development do
  gem 'mina'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end