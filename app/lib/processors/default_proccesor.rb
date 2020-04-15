module Processor
  # put it all together
  class DefaultProcessor

    def self.call
      new.call
    end
# mysql2://admin:cNSNkO7LWnpnq3Nrt7JH@database-1.ctbjvcdaq4ib.us-west-2.rds.amazonaws.com:3306
    def initialize
      @conn = Sequel.connect(ENV['database'] || 'mysql2://root:pass@mysql:3306')
    end

    def call
      reset_db
      migrate_db
      insert_data
    end

    private

    def reset_db
      puts 'dropping database'
      puts @conn.execute('drop database IF EXISTS visitor')
      puts 'dropping database FINISHED'
      puts 'creating database'
      puts @conn.execute('create database IF NOT EXISTS visitor')
      puts 'creating database FINISHED'
    end

    def migrate_db
      puts @conn.execute('use visitor')
      puts 'starting migration'
      Sequel.extension :migration
      puts Sequel::Migrator.run(@conn, '/app/lib/migrations/', use_transactions: false)
      puts 'migration finished'
    end

    def insert_data
      mapper = Mapper::DefaultMapper.new
      fetch_result = Fetcher::FakeFetcher.call(nil, nil).unwrap
      data = mapper.call(JSON.parse(fetch_result[:data]))
      data.each do |visit|
        page_views = visit.delete(:actionDetails)
        @conn[:visits].insert(visit)
        page_views.each do |pv|
          visit_id = { visit_id: @conn[:visits].order(:id).first[:id] }
          @conn[:page_views].insert(pv.merge(visit_id))
        end
      end
    end
  end
end
