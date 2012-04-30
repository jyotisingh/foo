class AssetsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @asset = Asset.new
  end

  def index
    @user = User.find(params[:user_id])
    @assets = @user.assets
  end

  def create
    @user = User.find(params[:user_id])
    @asset = Asset.new(params[:asset].merge({:fund => Fund.first}))
    @user.assets << @asset
    @user.valid?
    render :new and return unless @user.errors.empty?
    @user.save
    redirect_to user_assets_path
  end

  def edit
    @user = User.find(params[:user_id])
    @asset = @user.assets.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @asset = @user.assets.find(params[:id])
    @asset.update_attributes(params[:asset].merge({:fund => Fund.first}))
    @asset.valid?
    render :edit and return unless @asset.errors.empty?
    redirect_to user_assets_path
  end
end
