class Admin::PagesController < Admin::BaseController
  defaults :resource_class => Page
  private

  def permitted_params
    params.permit(:page=>[:title, :text, :position, :sort_order, :enabled, :image])
  end
end