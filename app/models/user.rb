class User < ActiveRecord::Base
  attr_accessible :nickname, :email, :provider, :uid

  validates :nickname, :email, :provider, :presence => true
  validates :uid, :presence => true, :uniqueness => { :scope => :provider }

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    end

    private

    def create_from_omniauth(auth)
      create(
        :nickname => auth["info"]["nickname"],
        :email    => auth["info"]["email"],
        :provider => auth["provider"],
        :uid      => auth["uid"],
      )
    end
  end
end
