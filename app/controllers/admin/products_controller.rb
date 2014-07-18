class Admin::ProductsController < Admin::BaseController
  defaults :resource_class => Product

  def autocomplete
    @products = Product.enabled.where("name like ?", "%#{params[:name]}%").limit(10)
    respond_to do |format|
      format.json { render json: @products.map { |product| product.as_json(:only => :id, :methods => :name) } }
    end
  end

  private

  def permitted_params
    params.permit(:product=>[:name, :description, :sku, :price, :count, :enabled, :seo_attributes=>[:title, :description, :keywords], :images_attributes=>[:image, :_destroy, :id], :category_ids=>[], :linked_category_ids=>[], :linked_product_ids=>[], seo_attributes: [:title, :description, :keywords]])
  end
end
