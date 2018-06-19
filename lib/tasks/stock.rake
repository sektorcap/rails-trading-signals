require 'yaml'
require 'stocks_analyzer'
include StocksAnalizer

namespace :stock do
  desc "Load stocks from a yaml file"
  task :load, [:market, :file] => :environment do |task, args|
    f = args[:file]
    unless File.exists?(f)
      puts "File #{f} does not exist. Unable to load stocks."
    else
      stocks = YAML.load_file(args[:file])
      count = 0
      stocks.each do |symbol, attrs|
        s = Stock.update_or_create_by({symbol: symbol}, attrs.merge({market: args[:market]}))
        puts s.inspect
        count += 1
      end
      puts "Loaded #{count} stocks"
    end
  end

  desc "Looking for new signals"
  task :check_signals => :environment do
    r = StocksAnalizer.analyze
    puts "Inserted #{r} signals."
    StockSignalsMailer.daily_mail.deliver_now
    puts "Mail inviata."
  end
end
