json.extract! portfolio_item, :id, :user_id, :stock_id, :avg_stock_value, :quantity, :sell_stock_value, :profit_loss, :notes, :created_at, :updated_at
json.url portfolio_item_url(portfolio_item, format: :json)
