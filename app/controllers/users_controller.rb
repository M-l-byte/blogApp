class UsersController < ApplicationController

  before_action :set_user
  def show
    @posts=@user.posts.all
  end

  private 

  def set_user
    @user=current_user
  end
end
