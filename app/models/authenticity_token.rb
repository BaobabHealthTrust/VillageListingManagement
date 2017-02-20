class AuthenticityToken < CouchRest::Model::Base
    
  use_database "authenticity_token"
    
  property :token, String
  property :username, String

  timestamps!

  def token
   self['_id']
  end

  def token=(value)
   self['_id'] = value
  end
 
  design do
    view :by_token
    view :by_username
  end

  
end
