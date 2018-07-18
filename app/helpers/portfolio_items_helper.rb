module PortfolioItemsHelper
  def display_profit_loss n
    k = (n >= 0)? 'profit' : 'loss'
    content_tag :div, class: k do
      number_with_precision(n, precision: 2, strip_insignificant_zeros: true)
    end
  end
end
