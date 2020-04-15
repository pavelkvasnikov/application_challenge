# initial migration
Sequel.migration do
  up do
    create_table(:visits) do
      primary_key :id
      String :evid
      String :vendor_site_id
      String :vendor_visit_id
      String :visit_ip
      String :vendor_visitor_id
    end

    create_table(:page_views) do
      primary_key :id
      foreign_key :visit_id, :visits
      String :title
      String :position
      String :url, text: true
      String :time_spent
      BigDecimal :timestamp, size: [14, 3]
    end
  end

  down do
    drop_table(:visits)
    drop_table(:page_views)
  end
end
