class Admin::FundsController < ApplicationController
  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(params[:fund])
    @fund.valid?
    render :new and return unless @fund.errors.empty?
    @fund.save!
    redirect_to admin_funds_path, :notice => "Fund created!"
  end

  def index
    @funds = Fund.all
  end
end
