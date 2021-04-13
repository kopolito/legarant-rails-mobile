# frozen_string_literal: true

class DeviseCreateContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :encrypted_password, :string, null: false, default: ""
    add_column :contacts, :reset_password_token, :string, null: false, default: ""
    add_column :contacts, :reset_password_sent_at, :datetime, null: false, default: ""
    add_column :contacts, :remember_created_at, :datetime, null: false, default: ""

    add_index :contacts, :reset_password_token, unique: true

  end
end
