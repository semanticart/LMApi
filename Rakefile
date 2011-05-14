require 'rubygems'
require 'bundler'

Bundler.require

require File.dirname(__FILE__) + '/app'

namespace :db do
  desc "Migrate the database"
  task(:migrate) do
    ActiveRecord::Migration.verbose = true
    ActiveRecord::Migrator.migrate("db/migrate")
  end
end
