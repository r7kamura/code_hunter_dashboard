class Report < ActiveRecord::Base
  has_many :warnings

  scope :descending, lambda {
    order("created_at DESC")
  }

  def self.create_with_warnings(warning_attributes_set)
    create.tap do |report|
      warning_attributes_set.each do |attributes|
        report.warnings.create(attributes)
      end
    end
  end

  def self.latest
    descending.first
  end
end
