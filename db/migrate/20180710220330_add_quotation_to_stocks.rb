class AddQuotationToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :quotation_date, :datetime
    add_column :stocks, :quotation_check, :datetime
    add_column :stocks, :quotation, :float
  end
end
