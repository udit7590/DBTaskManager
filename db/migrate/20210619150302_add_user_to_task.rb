class AddUserToTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user
    add_column :users, :contact_tag_id, :string
  end
end
