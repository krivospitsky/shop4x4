class Admin::CategoriesController < Admin::BaseController

  # def autocomplete
  #   @category = Category.enabled.where("name like ?", "%#{params[:name]}%").limit(10)
  #   respond_to do |format|
  #     format.json { render json: @category.map { |category| category.as_json(:only => :id, :methods => :name) } }
  #   end
  # end

  private

  def permitted_params
    params.permit(:category=>[:name, :description, :enabled, :parent_id, :image, :linked_category_ids=>[], :linked_product_ids=>[]], seo_attributes: [:title, :description, :keywords])
  end
end
