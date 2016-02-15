class Admin < ActiveRecord::Base
  scope :sorted, lambda { order("admins.created_at DESC")}
  scope :search, lambda {|query|
    where(["name LIKE ?", "%#{query}%"])
  }
end
