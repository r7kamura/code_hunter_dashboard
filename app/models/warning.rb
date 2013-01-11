class Warning < ActiveRecord::Base
  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  belongs_to :report

  scope :brakeman, lambda {
    where(:service => "brakeman")
  }
  scope :rails_best_practices, lambda {
    where(:service => "rails_best_practices")
  }

  after_create :increment_counter_cache

  def save(*)
    self[:modified_at] = Time.at(modified_at + 9.hours) if modified_at.is_a? Fixnum
    super
  end

  private

  def increment_counter_cache
    if %w[brakeman rails_best_practices].include?(service)
      report.increment!("#{service}_count")
    end
  end
end
