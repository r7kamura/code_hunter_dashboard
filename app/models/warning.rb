class Warning < ActiveRecord::Base
  SERVICE_TYPE_TABLE = {
    "rails_best_practices" => "Bad Smell",
    "pendaxes"             => "Pending",
    "brakeman"             => "Secutiry",
  }

  SERVICE_SEVERITY_TABLE = {
    "rails_best_practices" => "default",
    "pendaxes"             => "warning",
    "brakeman"             => "important",
  }

  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  belongs_to :report

  after_create :increment_counter_cache

  def save(*)
    self[:modified_at] = Time.at(modified_at + 9.hours) if modified_at.is_a? Fixnum
    super
  end

  def type
    SERVICE_TYPE_TABLE[service]
  end

  def severity
    SERVICE_SEVERITY_TABLE[service]
  end

  private

  def increment_counter_cache
    attribute = "#{service}_count"
    report.increment!(attribute) if report.respond_to?(attribute)
  end
end
