class Fund < ActiveRecord::Base
  key :name, String, :required => true 
  key :type, String, :required => true  
  key :nav, Float, :required => true 
  key :last_updated_date, Date
  key :archived_navs, Hash
  def nav=(value)
    self.archived_navs[self.last_updated_date.to_s] = self.nav unless self.last_updated_date == Date.today or self.last_updated_date.nil?
    self.last_updated_date = Date.today
    super
  end
end

