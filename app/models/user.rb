class User < ApplicationRecord
  self.table_name = "salesforce.contact"

  def password
    return encrypted_password__c
  end

  # def password_digest=(value)
  #   return encrypted_password__c
  # end

  def hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  def valid_password(hash)
    BCrypt::Password.new(hash) == self.encrypted_password__c
  end
end
