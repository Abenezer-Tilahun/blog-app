class AddUserRef < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts :comments :likes, :author, foreign_key: { to_table: :users }
  end
end
