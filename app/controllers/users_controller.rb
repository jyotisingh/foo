class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.valid?
    render :new and return unless @user.errors.empty?
    @user.save!
  end
end
