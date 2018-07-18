class CreatePortfolioItems < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_items do |t|
      t.references :user, foreign_key: true
      t.references :stock, foreign_key: true
      t.float :avg_stock_value
      t.integer :quantity
      t.float :sell_stock_value
      t.string :notes
      t.boolean :closed, default: false

      t.timestamps
    end
  end
end
