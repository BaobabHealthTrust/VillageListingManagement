require 'couchrest_model'

class User < CouchRest::Model::Base
    
  use_database "users"
    
  def username
   self['_id']
  end

  def username=(value)
   self['_id'] = value
  end
 
  property :first_name, String
  property :last_name, String
  property :password_hash, String
  property :active, TrueClass, :default => false
  property :role, String
  property :district_id, String
  property :ta_id, String
  property :village_id, String
  property :creator, String
  
  timestamps!

  cattr_accessor :current_user

  def has_role?(role_name)
    self.current_user.role == role_name ? true : false
  end

  before_save do |pass|
    self.password_hash = BCrypt::Password.create(self.password_hash) if not self.password_hash.blank?
    self.creator = 'admin' if self.creator.blank?
  end
 
  def password_matches?(plain_password)
    not plain_password.nil? and self.password == plain_password
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  rescue BCrypt::Errors::InvalidHash
    Rails.logger.error "The password_hash attribute of User[#{self.username}] does not contain a valid BCrypt Hash."
    return nil
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end
 
end
