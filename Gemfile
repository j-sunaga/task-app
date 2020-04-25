# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
ruby '2.6.3'
gem 'rails', '~> 5.2.3'

# middle ware
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'

# secure password
gem 'bcrypt', '3.1.11'

# view/front
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Japanese for enum
gem 'enum_help'

# pagenation
gem 'kaminari', '~> 0.17.0'

gem 'rubocop', require: false
gem 'rubocop-rails', require: false

gem 'dotenv-rails' # 開発環境で環境変数を操作するのに必要
gem 'unicorn' # アプリケーションサーバのunicorn
gem 'mini_racer', platforms: :ruby # デプロイ時に必要

group :development, :test do
  gem 'capistrano', '3.6.0' # capistranoのツール一式
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8'

  # Debug
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-nav'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'webdrivers'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
