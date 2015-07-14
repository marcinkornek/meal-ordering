class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
