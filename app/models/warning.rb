class Warning < ActiveRecord::Base
  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1

  belongs_to :report

  after_create :increment_counter_cache

  def save(*)
    self[:modified_at] = Time.at(modified_at + 9.hours) if modified_at.is_a? Fixnum
    super
  end

  private

  def increment_counter_cache
    attribute = "#{service}_count"
    report.increment!(attribute) if report.respond_to?(attribute)
  end
end
