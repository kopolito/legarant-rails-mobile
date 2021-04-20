class Contract < ApplicationRecord
  self.table_name = "salesforce.contract"
  belongs_to :account, foreign_key: "accountid"

  def account_name
    Account.where({sfid: self.accountid}).last.name
  end
end
