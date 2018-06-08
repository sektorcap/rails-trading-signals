class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.string :name
      t.float :dividend
      t.string :market

      t.timestamps
    end
  end
end
