class Fund < ActiveRecord::Base
  attr_accessible :name, :fund_type, :nav, :last_updated_date, :archived_navs
  has_many :archived_navs
  validates :name, :fund_type, :nav, :presence => true
  def nav=(value)
    unless self.last_updated_date == Date.today or self.last_updated_date.nil?
      self.archived_navs << ArchivedNav.new({:date => self.last_updated_date.to_s, :nav => self.nav})
    end
    self.last_updated_date = Date.today
    super
  end
end

