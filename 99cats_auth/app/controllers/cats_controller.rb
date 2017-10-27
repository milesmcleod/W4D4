class CatsController < ApplicationController
  before_action :owns_cat, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  helper_method :owns_cat

  def owns_cat
    if !self.logged_in?
      redirect_to cats_url
    elsif self.current_user.cats.where(id: params[:id]).to_a.empty?
      redirect_to cats_url
    else
      true
    end
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = self.current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
