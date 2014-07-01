class CategoriesController < ApplicationController
  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
    @title = @category.name
  end
end
