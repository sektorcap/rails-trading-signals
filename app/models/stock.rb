class Stock < ApplicationRecord
  has_many :stock_signals, dependent: :destroy
  has_many :portfolio_items, dependent: :destroy, inverse_of: :stock
  validates_presence_of :symbol
  validates_uniqueness_of :symbol
  validates_presence_of :name
  validates_uniqueness_of :name

  def self.update_or_create_by(args, attributes)
    obj = self.find_or_create_by(args)
    obj.update(attributes)
    return obj
  end

end
