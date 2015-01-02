class Admin::PagesController < Admin::BaseController
	private

	def permitted_params
		params.require(:page).permit(:name, :text, :position, :sort_order, :enabled, :image, :sort_order_position, seo_attributes: [:title, :description, :keywords])
	end
end