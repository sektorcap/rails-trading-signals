class PortfolioItem < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  attr_accessor :stock_ids

  def sell_stock_value
    return self[:sell_stock_value] if closed?
    return stock.quotation if stock && stock.quotation
    nil
  end

  def profit_loss
    (sell_stock_value-avg_stock_value)*quantity
  end

  def closed?
    closed
  end

  def closed_text
    return "chiusa" if closed?
    "aperta"
  end

end
