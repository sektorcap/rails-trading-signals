require 'test_helper'

class StockSignalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_signals_index_url
    assert_response :success
  end

end
