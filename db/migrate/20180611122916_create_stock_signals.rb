class CreateStockSignals < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_signals do |t|
      t.datetime :quotation_date
      t.float :quotation
      t.float :min_year
      t.float :max_year
      t.float :volatility
      t.float :dividend_yield
      t.string :description
      t.string :details
      t.integer :suggestion
      t.integer :level
      t.references :stock, foreign_key: true

      t.timestamps
    end
  end
end
