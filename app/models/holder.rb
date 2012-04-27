class Holder < ActiveModel
  key :name, String
  has_many :investments
end
