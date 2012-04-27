class Holder < ActiveRecord::Base
  key :name, String, :required => true
  many :investments
  validates_associated :investments

  def assets_value
    value = 0
    investments.collect(&:value).each{|v| value +=v}
    value
  end
end

