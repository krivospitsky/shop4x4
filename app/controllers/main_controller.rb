class MainController < ApplicationController
  def show
  	@banners=Promotion.current_banners
  	@categories=Category.root.enabled
  end
end
