# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

begin
  ActiveRecord::Migration.check_pending!
rescue ActiveRecord::PendingMigrationError
  puts "Ejecutando migraciones pendientes..."
  ActiveRecord::Migrator.migrate("db/migrate/")
end


run Rails.application
Rails.application.load_server
