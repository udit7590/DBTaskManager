class AddContactIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :active_campaign_contact_id, :string
  end
end
