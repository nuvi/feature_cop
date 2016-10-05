require "rails/generators"
require "rails/generators/active_record"

module Featurecop
  class MigrationsGenerator < ::Rails::Generators::Base
    include ::Rails::Generators::Migration
    desc "Writes migration(s) needed for featurecop DB."

    source_root File.expand_path("../migrations", __FILE__)

    def create_migration_file
      write_migration("create_user_list_table")
    end

    def self.next_migration_number(directory)
      ::ActiveRecord::Generators::Base.next_migration_number(directory)
    end

    private

    def write_migration(file_name)
      directory = File.expand_path("db/migrate")
      migration_template "#{file_name}.rb", "db/migrate/#{file_name}.rb"
    end

  end
end