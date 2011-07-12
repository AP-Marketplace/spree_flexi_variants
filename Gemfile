source 'http://rubygems.org'

# temporarily needed until next capybara release
gem 'selenium-webdriver', '0.2.1'

group :test do
  gem 'database_cleaner', '= 0.6.7'
  gem 'rspec-rails', '= 2.6.1'
  gem 'factory_girl', '= 1.3.3'
  gem 'factory_girl_rails', '= 1.0.1'
  gem 'rcov'
  gem 'shoulda'
  gem 'faker'
  if RUBY_VERSION < "1.9"
    gem "ruby-debug"
  else
    gem "ruby-debug19"
  end
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'database_cleaner', '= 0.6.7'
  gem 'nokogiri', '1.4.4'
  gem 'capybara', '= 1.0.0'
  gem 'factory_girl', '= 1.3.3'
  gem 'factory_girl_rails', '= 1.0.1'
  gem 'faker'
  gem 'launchy'

  if RUBY_VERSION < "1.9"
    gem "ruby-debug"
  else
    gem "ruby-debug19"
  end
end

gem 'spree', 'git://github.com/spree/spree.git'
gem 'carrierwave'
gem 'rmagick'
gem 'sqlite3-ruby'
