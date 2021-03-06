class Variant < ActiveRecord::Base
  belongs_to :product
  scope :enabled, -> { where(enabled: 't') }

  serialize :attr, Hash

  mount_uploader :image, ImageUploader


  def discount_price
    max_discount1 = Promotion.current.joins(:products).where('products.id = ?', product.id).maximum(:discount) || 0
    max_discount2 = Promotion.current.joins(:categories).where('categories.id in (?)', product.categories.pluck(:id)).maximum(:discount) || 0
    max_discount = [max_discount1, max_discount2].max

    #prices=variants.map {|v| v.price}   
    if max_discount>0
      return price * (100 - max_discount) / 100
      # if prices.min == prices.max
      #   return prices[0] * (100 - max_discount) / 100
      # else
      #   return "от #{prices.min * (100 - max_discount) / 100} до #{prices.max * (100 - max_discount) / 100}"
      # end
    end

    false
  end


  def price_str(quantity=1)
    if !price
      "по запросу"
    elsif discount_price
      "<del>#{price*quantity}</del> #{discount_price*quantity} руб."
    else
      "#{price*quantity} руб."
    end
  end
end
