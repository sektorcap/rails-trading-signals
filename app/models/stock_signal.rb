class StockSignal < ApplicationRecord
  enum suggestion: [ :buy, :sell ]
  enum level: [ :low, :medium, :high ]
  belongs_to :stock
  belongs_to :stock_signal_check
end
