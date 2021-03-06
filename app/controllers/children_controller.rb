class ChildrenController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    policy_scope(current_user.family.user)
    @children = current_user.family.user.where(child: true)
  end

  def show
    @child = User.find(params[:id])
    authorize @child
  end

  def new
    @child = User.new
    authorize @child
  end

  def create
    @child = User.new(params[:child])
    authorize @child
    if @child.save
      UserMailer.welcome(@child).deliver_now
      redirect_to childrens_path
    else 
      render :new
    end
  end

  private

  # def children_params
  #   params.require(:children).permit
  # end



end
