require 'couchrest_model'

class Village < CouchRest::Model::Base
    
  use_database "village"
    
  property :name, String
  property :ta_id, String
  
  timestamps!

  design do
    view :by_name
  end

  design do
    view :by_ta_id_and_name
  end

  design do
    view :by_ta_id
  end

end
