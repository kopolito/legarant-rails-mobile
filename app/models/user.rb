class User < ApplicationRecord
  self.table_name = "salesforce.contact"

  validates :email, :uniqueness => true, :presence => true
  validates :phone, :allow_blank => true, :numericality => true, :length => { :minimum => 10, :maximum => 15 }

  validates :mobilephone, :allow_blank => true, :numericality => true, :length => { :minimum => 10, :maximum => 15 }

  def password
    return encrypted_password__c
  end

  # def password_digest=(value)
  #   return encrypted_password__c
  # end

  def self.hash_password(password)
    BCrypt::Password.create(password).to_s
  end

  def valid_password(pass)
    BCrypt::Password.new(self.encrypted_password__c) == pass
  end

  def contracts
    Contract.where({accountid: self.accountid})
  end
end

