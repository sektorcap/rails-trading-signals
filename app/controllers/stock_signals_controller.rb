class StockSignalsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_stock_signal_check, only: [:index]

  def index
    @signals = @stock_signal_check.stock_signals
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_signal_check
      if params[:id]
        @stock_signal_check = StockSignalCheck.find(params[:id])
      else
        @stock_signal_check = StockSignalCheck.last
      end
    end

end
