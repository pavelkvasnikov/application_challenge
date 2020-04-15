module Mapper
  # class which transform JSON into data sets
  class DefaultMapper < Dry::Transformer::Pipe
    import Dry::Transformer::ArrayTransformations
    import Dry::Transformer::HashTransformations

    define! do
      map_array do
        symbolize_keys

        rename_keys referrerName: :evid
        rename_keys idSite: :vendor_site_id
        rename_keys idVisit: :vendor_visit_id
        rename_keys visitIp: :visit_ip
        rename_keys visitorId: :vendor_visitor_id

        accept_keys [
                        :evid,
                        :vendor_site_id,
                        :vendor_visit_id,
                        :vendor_visitor_id,
                        :actionDetails,
                        :visit_ip
                    ]

        # replace 'evid_' prefix and match against Regex
        map_value :evid, -> v do
          formatted = v.gsub('evid_', '')
          formatted.match(/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/) ? formatted : ''
        end
        # something went wrong there :(
        map_value :actionDetails, -> v {
          v.map.with_index do |vv, i|
            {
                url: vv['url'],
                title: vv['pageTitle'],
                time_spent: vv['timeSpent'],
                timestamp: vv['timestamp'],
                position: i
            }
          end
        }

      end
    end
  end


end
