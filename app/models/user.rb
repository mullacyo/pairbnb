class User < ApplicationRecord
  include Clearance::User

# ====== GOOGLE AUTH BEGINS HERE ========
  has_many :authentications, dependent: :destroy
  has_many :listings

 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     first_name: auth_hash["info"]["given_name"],
     last_name: auth_hash["info"]["family_name"],
     email: auth_hash["info"]["email"],
     birthdate: auth_hash["info"]["birthday"],
     gender: auth_hash["info"]["gender"]
   )
   user.authentications << authentication
   return user
 end

 # grab google to access google for user data
 def google_token
   x = self.authentications.find_by(provider: 'google_oauth2')
   return x.token unless x.nil?
 end

 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     first_name: auth_hash["info"]["given_name"],
     last_name: auth_hash["info"]["family_name"],
     email: auth_hash["info"]["email"],
     birthdate: auth_hash["info"]["birthday"],
     gender: auth_hash["info"]["gender"],
     password: SecureRandom.hex(10)
   )
   user.authentications << authentication
   return user
 end
# ====== GOOGLE AUTH ENDS HERE ========
end

