class Warning < ActiveRecord::Base
  SERVICE_TYPE_TABLE = {
    "rails_best_practices" => "Bad Smell",
    "pendaxes"             => "Pending",
    "brakeman"             => "Security",
  }

  SERVICE_SEVERITY_TABLE = {
    "rails_best_practices" => "default",
    "pendaxes"             => "warning",
    "brakeman"             => "important",
  }

  attr_accessible :author, :email, :line, :message, :modified_at, :path, :service, :sha1, :url

  belongs_to :report

  after_create :increment_counter_cache

  scope :recently_modified, lambda { order("modified_at DESC") }

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

  def github_file_path
    if Settings.github.repository
      [
        "https:/",
        Settings.github.host,
        Settings.github.repository,
        "blob",
        sha1,
        Settings.github.rails_root,
        "#{path}#L#{line}"
      ].compact.join("/")
    end
  end

  def github_commit_path
    if Settings.github.repository
      [
        "https:/",
        Settings.github.host,
        Settings.github.repository,
        "commit",
        sha1,
      ].join("/")
    end
  end

  def path_with_line
    [path, line].join(":")
  end

  private

  def increment_counter_cache
    attribute = "#{service}_count"
    report.increment!(attribute) if report.respond_to?(attribute)
  end
end
