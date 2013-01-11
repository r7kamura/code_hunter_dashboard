class Warning < ActiveRecord::Base
  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  belongs_to :report, :counter_cache => true

  scope :brakeman, lambda {
    where(:service => "brakeman")
  }
  scope :rails_best_practices, lambda {
    where(:service => "rails_best_practices")
  }

  def save(*)
    self[:modified_at] = Time.at(modified_at + 9.hours) if modified_at.is_a? Fixnum
    super
  end
end
