class ArchivedNav < ActiveRecord::Base
  attr_accessible :date, :nav
  belongs_to :fund
end

