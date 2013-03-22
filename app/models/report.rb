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

  def time
    created_at.strftime("%Y-%m-%d %H:%M")
  end

  def added_warnings
    hash = previous_warnings.group_by(&:sha1)
    warnings.reject {|warning| hash[warning.sha1] }
  end

  def removed_warnings
    hash = warnings.group_by(&:sha1)
    previous_warnings.reject {|warning| hash[warning.sha1] }
  end

  private

  def previous
    self.class.where("created_at < ?", created_at).descending.first
  end

  def previous_warnings
    previous.try(:warnings) || []
  end
end
