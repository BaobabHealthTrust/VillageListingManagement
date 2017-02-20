require 'couchrest_model'

class Country < CouchRest::Model::Base
    
  use_database "countries"
    
  def name
   self['_id']
  end

  def name=(value)
   self['_id'] = value
  end
 
  property :code, String
  property :name, String
  
  timestamps!

  ########################## views start ####################################
  design do
    view :by__id
  end

  design do
    view :by_name
  end
  ########################## views ends ####################################

end
