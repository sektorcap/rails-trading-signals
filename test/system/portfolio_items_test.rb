require "application_system_test_case"

class PortfolioItemsTest < ApplicationSystemTestCase
  setup do
    @portfolio_item = portfolio_items(:one)
  end

  test "visiting the index" do
    visit portfolio_items_url
    assert_selector "h1", text: "Portfolio Items"
  end

  test "creating a Portfolio item" do
    visit portfolio_items_url
    click_on "New Portfolio Item"

    fill_in "Avg Stock Value", with: @portfolio_item.avg_stock_value
    fill_in "Notes", with: @portfolio_item.notes
    fill_in "Profit Loss", with: @portfolio_item.profit_loss
    fill_in "Quantity", with: @portfolio_item.quantity
    fill_in "Sell Stock Value", with: @portfolio_item.sell_stock_value
    fill_in "Stock", with: @portfolio_item.stock_id
    fill_in "User", with: @portfolio_item.user_id
    click_on "Create Portfolio item"

    assert_text "Portfolio item was successfully created"
    click_on "Back"
  end

  test "updating a Portfolio item" do
    visit portfolio_items_url
    click_on "Edit", match: :first

    fill_in "Avg Stock Value", with: @portfolio_item.avg_stock_value
    fill_in "Notes", with: @portfolio_item.notes
    fill_in "Profit Loss", with: @portfolio_item.profit_loss
    fill_in "Quantity", with: @portfolio_item.quantity
    fill_in "Sell Stock Value", with: @portfolio_item.sell_stock_value
    fill_in "Stock", with: @portfolio_item.stock_id
    fill_in "User", with: @portfolio_item.user_id
    click_on "Update Portfolio item"

    assert_text "Portfolio item was successfully updated"
    click_on "Back"
  end

  test "destroying a Portfolio item" do
    visit portfolio_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Portfolio item was successfully destroyed"
  end
end
