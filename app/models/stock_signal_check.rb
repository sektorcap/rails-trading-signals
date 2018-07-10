class StockSignalCheck < ApplicationRecord
  has_many :stock_signals, dependent: :destroy
end
