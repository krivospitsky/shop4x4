class Variant < ActiveRecord::Base
  belongs_to :product
  scope :enabled, -> { where(enabled: 't') }

  def price_str
    max_discount1 = Promotion.current.joins(:products).where('products.id = ?', product.id).maximum(:discount) || 0
    max_discount2 = Promotion.current.joins(:categories).where('categories.id in (?)', product.categories.pluck(:id)).maximum(:discount) || 0
    max_discount = [max_discount1, max_discount2].max

    return "<del>#{price}</del> #{price * (100 - max_discount) / 100} руб." if max_discount
    return "#{price} руб." if max_discount
  end

end
