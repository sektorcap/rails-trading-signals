require 'test_helper'

class StockSignalChecksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_signal_checks_index_url
    assert_response :success
  end

end
