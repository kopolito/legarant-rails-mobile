class Account < ApplicationRecord
  self.table_name = "salesforce.account"
  has_many :contacts, foreign_key: "sfid"
  #has_many :contracts, foreign_key: "sfid"
end
