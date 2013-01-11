class Warning < ActiveRecord::Base
  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  belongs_to :report
end
