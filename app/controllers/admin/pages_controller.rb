class Admin::PagesController < Admin::BaseController
  defaults :resource_class => Page
  private

  def permitted_params
    params.permit(:page=>[:name, :text, :position, :sort_order, :enabled, :image, :sort_order_position], seo_attributes: [:title, :description, :keywords])
  end
end