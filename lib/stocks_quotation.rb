require 'alphavantage_client'
include AlphavantageClient

module StocksQuotation
  def get_quotations
    t = Time.now
    count = 0
    Stock.all.each do |stock|
      timeseries = daily_stock stock.symbol

      # this is a fix because sometimes Alphavantage returns some data set to 0
      close = timeseries.close.select{|i| i[1].to_f > 0}

      Rails.logger.info "#{stock.name} (#{stock.symbol}): #{close[0]}"

      # update stock quotation
      stock.quotation = close[0][1].to_f
      stock.quotation_date = DateTime.parse(close[0][0])
      stock.quotation_check = t
      stock.save
      count += 1
    end
    count
  end
end
