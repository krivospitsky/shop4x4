class Admin::CategoriesController < Admin::BaseController

  # def autocomplete
  #   @category = Category.enabled.where("name like ?", "%#{params[:name]}%").limit(10)
  #   respond_to do |format|
  #     format.json { render json: @category.map { |category| category.as_json(:only => :id, :methods => :name) } }
  #   end
  # end


  def index
    @categories=Category.root
    respond_with @categories
  end

  private

  def permitted_params
    params.require(:category).permit(:name, :description, :enabled, :parent_id, :image, :sort_order_position, :linked_category_ids=>[], :linked_product_ids=>[], seo_attributes: [:title, :description, :keywords])
  end
end
