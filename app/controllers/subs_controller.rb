class SubsController < ApplicationController
  before_action :require_moderator, except: [:index, :new, :create, :show]
  def index
    @subs = Sub.all
    render :index
  end

  def new
    if logged_in?
      @sub = Sub.new
      render :new
    else
      redirect_to subs_url
    end
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    end
  end

  def show

    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if  @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:moderator_id, :name, :description)
  end

  def require_moderator
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      flash.now[:errors] ||= []
      flash.now[:errors] << "You have to be a moderator to edit!"
      render :show
    end
  end
end
