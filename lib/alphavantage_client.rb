require 'alphavantagerb'

module AlphavantageClient
  DEFAULT_WAITING_TIME = 5
  DEFAULT_RETRY = 10

  def alphavantage_client
    AlphavantageClient.alphavantage_client
  end
  def alphavantage_config
    AlphavantageClient.alphavantage_config
  end

  def self.alphavantage_config
    return @alphavantage_config if @alphavantage_config
    @alphavantage_config = {}
    @alphavantage_config[:verbose] = Settings.alphavantage.verbose || false
    @alphavantage_config[:waiting_time] = Settings.alphavantage.waiting_time || DEFAULT_WAITING_TIME
    @alphavantage_config[:retry] = Settings.alphavantage.retry || DEFAULT_RETRY
    @alphavantage_config
  end

  def self.alphavantage_client
    return @alphavantage_client if @alphavantage_client
    key  = ENV['ALPHAVANTAGE_KEY']  rescue "demo"
    @alphavantage_client = Alphavantage::Client.new key: key, verbose: alphavantage_config[:verbose]
    @alphavantage_client
  end

  def daily_stock symbol
    attempts = 0
    while true
      begin
        stock = alphavantage_client.stock symbol: symbol
        return stock.timeseries outputsize: "full"
      rescue Alphavantage::Error => ex
        attempts += 1
        Rails.logger.warn "Attempts #{attempts} failed for #{symbol}"
        raise ex if attempts == alphavantage_config[:retry]
        Rails.logger.info "Waiting #{alphavantage_config[:waiting_time]} seconds"
        sleep alphavantage_config[:waiting_time]
      end
    end


  end
end
