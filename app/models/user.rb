class User < ActiveRecord::Base
  attr_accessible :name, :email
  has_many :assets
  validates_associated :assets
  validates :name, :email, :presence => true

  def assets_value
    value = 0
    assets.collect(&:value).each{|v| value +=v}
    value
  end
end

