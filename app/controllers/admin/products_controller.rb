class Admin::ProductsController < Admin::BaseController
  defaults :resource_class => Product

  def all_enabled_categories
    Category.where(enabled: true)
  end
  helper_method :all_enabled_categories

  private

  def permitted_params
    params.permit(:product=>[:name, :description, :price, :count, :enabled, :seo_attributes=>[:title, :description, :keywords], :images_attributes=>[:image, :_destroy, :id], :category_ids=>[]])
  end
end
