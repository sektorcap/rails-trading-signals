class CreateStockSignalChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_signal_checks do |t|

      t.timestamps
    end
  end
end
