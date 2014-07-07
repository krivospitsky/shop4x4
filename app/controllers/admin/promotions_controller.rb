class Admin::PromotionsController < Admin::BaseController
  defaults :resource_class => Promotion
  private

  def permitted_params
    params.permit(:promotion=>[:name, :description, :enabled, :has_banner, :banner, :send_mail, :start_at, :end_at, :discount, categories_ids:[], product_ids:[], seo_attributes: [:title, :description, :keywords]])
  end
end
