require "application_responder"

class Admin::BaseController < ActionController::Base
	layout 'admin'
	self.responder = ApplicationResponder
	respond_to :html
    responders :flash, :http_cache

	before_action :set_title
	before_action :authenticate_admin!


	@@resource_class = nil

	def index
		@objects=@@resource_class.all
		obj_name=ActiveModel::Naming.plural(@@resource_class)
		raise "obj_name=#{obj_name}"
		instance_variable_set("@#{obj_name}", @objects)
		respond_with @objects
	end


	def new
		@object = Page.new
		obj_name=ActiveModel::Naming.singular(@@resource_class)
		instance_variable_set("@#{obj_name}", @object)
		respond_with(@object)
    end

	def create
		@object = Page.create permitted_params
    	redirect_to admin_pages_path
	end

	def edit  
		@object = Page.find(params[:id])  
		obj_name=ActiveModel::Naming.singular(@@resource_class)
		instance_variable_set("@#{obj_name}", @object)
		respond_with(@object)  
	end  

	def update  
		@object = Page.find(params[:id])  
		@object.update_attributes permitted_params
    	redirect_to admin_pages_path
	end  

	def destroy  
		@object = Page.find(params[:id])  
		@object.destroy  
    	redirect_to admin_pages_path
	end  

	private

	def set_title
		@title = t("title.#{controller_name}.#{action_name}")
	end

	protected

end