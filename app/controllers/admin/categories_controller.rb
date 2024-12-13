class Admin::CategoriesController < ApplicationController
  username = Rails.configuration.basic_auth[:username]
  password = Rails.configuration.basic_auth[:password]
  http_basic_authenticate_with name: username, password: password

  def index
    @categories = Category.order(name: :asc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end


  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
