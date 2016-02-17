require 'couchrest_model'

class District < CouchRest::Model::Base
    
  use_database "district"
    
  property :district_code, String
  property :name, String
  property :region, String

  timestamps!

  design do
    view :by_district_code
    view :by_name
    view :by_region
  end

  
end
