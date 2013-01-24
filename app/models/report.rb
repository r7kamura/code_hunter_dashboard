class Report < ActiveRecord::Base
  attr_accessible :brakeman_count, :rails_best_practices_count, :pendaxes_count

  has_many :warnings, :order => "modified_at DESC"

  scope :descending, lambda {
    order("created_at DESC")
  }

  delegate :brakeman, :rails_best_practices, :to => :warnings

  def self.create_with_warnings(warning_attributes_set)
    create.tap do |report|
      warning_attributes_set.each do |attributes|
        report.warnings.create(attributes)
      end
    end
  end

  def self.latest
    descending.first or raise ActiveRecord::RecordNotFound
  end

  def brakeman
    warnings.brakeman
  end
end
