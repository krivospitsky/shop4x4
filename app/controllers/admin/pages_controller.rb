class Admin::PagesController < Admin::BaseController
  defaults :resource_class => Page
  private

  def permitted_params
    params.permit(:page=>[:name, :text, :position, :sort_order, :enabled, :image], seo_attributes: [:title, :description, :keywords])
  end
end