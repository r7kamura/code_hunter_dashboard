class Warning < ActiveRecord::Base
  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  def self.mass_create(attributes_set)
    attributes_set.map do |attributes|
      create(attributes)
    end
  end
end
