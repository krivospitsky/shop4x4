class Admin::CategoriesController < Admin::BaseController
  defaults :resource_class => Category
  private

  def permitted_params
    params.permit(:category=>[:name, :description, :enabled, :parent_id, :image])
  end
end
