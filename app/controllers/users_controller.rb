class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.valid?
    render :new and return unless @user.errors.empty?
    @user.save!
    redirect_to user_assets_path(@user), :notice => "Registration Successful!"
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    @user.valid?
    render :edit and return unless @user.errors.empty?
    redirect_to user_assets_path(@user), :notice => "Successfully updated profile!"
  end

  def edit
    @user = User.find(params[:id])
  end
end
