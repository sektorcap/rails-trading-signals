json.extract! stock, :id, :symbol, :name, :dividend, :market, :created_at, :updated_at
json.url stock_url(stock, format: :json)
