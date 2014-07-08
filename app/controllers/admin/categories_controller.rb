class Admin::CategoriesController < Admin::BaseController
  defaults :resource_class => Category
  private

  def permitted_params
    params.permit(:category=>[:name, :description, :enabled, :parent_id, :image, :linked_category_ids=>[], :linked_product_ids=>[]], seo_attributes: [:title, :description, :keywords])
  end
end
