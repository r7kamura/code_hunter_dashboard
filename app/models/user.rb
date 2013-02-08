class User < ActiveRecord::Base
  attr_accessible :emails, :image, :nickname, :provider, :token, :uid

  validates :emails, :nickname, :provider, :token, :presence => true
  validates :uid, :presence => true, :uniqueness => { :scope => :provider }

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    end

    private

    def create_from_omniauth(auth)
      user = new(
        :image    => auth["info"]["image"],
        :nickname => auth["info"]["nickname"],
        :token    => auth["credentials"]["token"],
        :provider => auth["provider"],
        :uid      => auth["uid"],
      )
      user.fetch_emails!
      user.tap(&:save)
    end
  end

  def emails
    self[:emails].try(:split, ",")
  end

  def emails=(emails)
    self[:emails] = emails.join(",")
  end

  def fetch_emails!
    self.emails = fetch_emails
  end

  def fetch_emails
    client.users.emails.all.map {|hash| hash.email }
  end

  private

  def client
    @client ||= Github.new(:oauth_token => token, :endpoint => Settings.github_api_endpoint)
  end
end
