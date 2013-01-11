class Report < ActiveRecord::Base
  has_many :warnings, :order => "modified_at DESC"

  scope :descending, lambda {
    order("created_at DESC")
  }

  delegate :brakeman, :to => :warnings
  delegate :rails_best_practices, :to => :warnings

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

  def brakeman
    warnings.brakeman
  end
end
