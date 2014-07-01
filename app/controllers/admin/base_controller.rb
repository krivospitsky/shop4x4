class Admin::BaseController < InheritedResources::Base
  layout 'admin'
  actions :all, :except => [ :show]
  before_action :set_title
  before_filter :authenticate_admin!

  private
  def set_title
    @title = t("title.#{controller_name}.#{action_name}")
  end

end