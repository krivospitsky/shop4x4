class PagesController < ApplicationController
  # GET /pages/1
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])
    @title=@page.title
  end
end
