class Admin::SettingsController < ApplicationController
  layout 'admin'

  def edit
    @current_settings=Settings.get_all
  end
  def update
    Settings.site_title=params[:settings][:site_title]
    Settings.site_url=params[:settings][:site_url]
    Settings.owner_phone=params[:settings][:owner_phone]
    Settings.owner_email=params[:settings][:owner_email]
    redirect_to '/admin/settings/edit'
  end
end
