require 'alphavantage_client'
include AlphavantageClient

module StocksAnalizer
  def analyze
    t = Time.now
    count = 0
    StockSignalCheck.transaction do
      check = StockSignalCheck.create
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

        ["signal_5_down", "one_year_min", "one_year_max"].each do |m|
          r, options = send(m, close)
          next unless r

          s = StockSignal.new
          s.stock_signal_check = check
          s.stock = stock
          s.quotation_date = DateTime.parse(close[0][0])
          s.quotation = close[0][1].to_f
          s.min_year = min_close(close)
          s.max_year = max_close(close)
          s.volatility = (s.max_year.to_f-s.min_year.to_f)/s.min_year.to_f
          s.dividend_yield = stock.dividend/s.quotation*0.74
          s.description = options[:message]
          s.details = options[:details]
          s.suggestion = options[:suggestion]
          s.level = options[:level]
          s.save!

          count += 1
        end
      end
    end
    count
  end

  def min_close ts
    m = ts[0..280].min{|x,y| x[1].to_f <=> y[1].to_f}
    m[1].to_f
  end
  def max_close ts
    m = ts[0..280].max{|x,y| x[1].to_f <=> y[1].to_f}
    m[1].to_f
  end

  def signal_5_down ts
    options = {}
    (0..3).each {|x| return false, options if ts[x][1] >= ts[x+1][1]}
    options[:message] = "Sceso 5 volte di fila"
    options[:details] = ts[0..4].map{|x| x[1]}
    options[:suggestion] = "buy"
    options[:level] = "low"
    return true, options
  end

  PERCENTAGE_MIN_THRESHOLD_1 = 0.95
  PERCENTAGE_MIN_THRESHOLD_2 = 0.99
  def one_year_min ts
    options = {}
    min_entry = ts[0..280].min{|x,y| x[1].to_f <=> y[1].to_f}
    options[:min_entry] = min_entry
    if (ts[0][1].to_f*PERCENTAGE_MIN_THRESHOLD_1 <= min_entry[1].to_f)
      options[:message] = "Nei pressi del minimo dell'ultimo anno"
      options[:details] = min_entry
      options[:suggestion] = "buy"
      options[:level] = ts[0][1].to_f*PERCENTAGE_MIN_THRESHOLD_2 <= min_entry[1].to_f ? "high" : "medium"
      return true, options
    else
      return false, options
    end
  end

  PERCENTAGE_MAX_THRESHOLD = 0.95
  def one_year_max ts
    options = {}
    max_entry = ts[0..280].max{|x,y| x[1].to_f <=> y[1].to_f}
    options[:max_entry] = max_entry
    if (ts[0][1].to_f >= max_entry[1].to_f*PERCENTAGE_MAX_THRESHOLD)
      options[:message] = "Nei pressi del massimo dell'ultimo anno"
      options[:details] = max_entry
      options[:suggestion] = "sell"
      options[:level] = "high"
      return true, options
    else
      return false, options
    end
  end

end
