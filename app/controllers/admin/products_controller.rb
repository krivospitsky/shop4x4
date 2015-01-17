class Admin::ProductsController < Admin::BaseController
  
  # def autocomplete
  #   @products = Product.enabled.where("products.name like ?", "%#{params[:name]}%").limit(10)
  #   respond_to do |format|
  #     format.json { render json: @products.map { |product| product.as_json(:only => :id, :methods => :name) } }
  #   end
  # end

  private

  def permitted_params
    params.require(:product).permit(:name, :description, :sku, :price, :count, :enabled, :sort_order, :sort_order_position, :seo_attributes=>[:title, :description, :keywords], :images_attributes=>[:image, :_destroy, :id], :category_ids=>[], :linked_category_ids=>[], :linked_product_ids=>[], variants_attributes: [:id, :sku, :enabled, :name, :price, :count, :_destroy] ,seo_attributes: [:title, :description, :keywords])
  end
end
