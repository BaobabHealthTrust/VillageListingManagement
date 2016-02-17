require 'couchrest_model'

class TraditionalAuthority < CouchRest::Model::Base
    
  use_database "traditional_authority"
    
  property :name, String
  property :district_id, String
  property :region, String
  
  timestamps!

  design do
    view :by_name
  end

  design do
    view :by_district_id_and_name
  end

  design do
    view :by_region_and_name
  end

  design do
    view :by_region
  end

  design do
    view :by_district_id
  end

end
