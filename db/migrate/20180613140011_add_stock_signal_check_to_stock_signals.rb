class AddStockSignalCheckToStockSignals < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_signals, :stock_signal_check, foreign_key: true
  end
end
