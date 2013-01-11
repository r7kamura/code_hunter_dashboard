class Report < ActiveRecord::Base
  has_many :warnings

  def self.create_with_warnings(warning_attributes_set)
    create.tap do |report|
      warning_attributes_set.each do |attributes|
        report.warnings.create(attributes)
      end
    end
  end
end
