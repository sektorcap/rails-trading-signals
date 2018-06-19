class StockSignalsMailer < ApplicationMailer
  def daily_mail
    @signals = StockSignalCheck.last.stock_signals.sort_by{|s| s.stock.symbol} rescue nil
    mail to: ENV['CCTS_MAIL_TO'], from: "sektor@#{ENV['MAILGUN_DOMAIN']}", subject: "Rails Trading Signals from CCTS!"
  end
end
