class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :consumer_id
      t.string :state, default: 'ordered'
      t.string :product_name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
