class StockSignalsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_stock_signals

  def index
    if session[:view_format] == "full"
      redirect_to :action => "full", :check_id => params[:check_id]
    elsif session[:view_format] == "compact"
      redirect_to :action => "compact", :check_id => params[:check_id]
    else
      render :action => "full"
    end
  end

  def full
    session[:view_format] = "full"
  end

  def compact
    session[:view_format] = "compact"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_signals
      if params[:check_id]
        @stock_signal_check = StockSignalCheck.find(params[:check_id])
      else
        @stock_signal_check = StockSignalCheck.last
      end
      @signals = @stock_signal_check.stock_signals
    end

end
