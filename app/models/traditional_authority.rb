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

end
