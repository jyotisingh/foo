class AssetsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @asset = Asset.new
    @funds = Fund.all
  end

  def index
    @user = User.find(params[:user_id])
    @assets = @user.assets
  end

  def create
    @user = User.find(params[:user_id])
    @asset = Asset.new(params[:asset])
    @user.assets << @asset
    @user.valid?
    render :new and return unless @user.errors.empty?
    @user.save
    redirect_to user_assets_path, :notice => "Successfully added!"
 
  end

  def edit
    @user = User.find(params[:user_id])
    @asset = @user.assets.find(params[:id])
    @funds = Fund.all
  end

  def update
    @user = User.find(params[:user_id])
    @asset = @user.assets.find(params[:id])
    @asset.update_attributes(params[:asset])
    @asset.valid?
    render :edit and return unless @asset.errors.empty?
    redirect_to user_assets_path, :notice => "Successfully updated!"
  end

  def destroy
    @user = User.find(params[:user_id])
    @asset = @user.assets.find(params[:id])
    @asset.destroy
    redirect_to user_assets_path, :notice => "Successfully deleted!"
  end
end
