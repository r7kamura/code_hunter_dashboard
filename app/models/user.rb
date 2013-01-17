class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid
end
