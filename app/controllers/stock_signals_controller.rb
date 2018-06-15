class StockSignalsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @signals = StockSignalCheck.last.stock_signals
  end
end
