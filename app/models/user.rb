class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  validates :name, :presence => true
  validates :provider, :presence => true
  validates :uid, :presence => true, :uniqueness => { :scope => :provider }

  has_many :entries

  class << self
    def from_omniauth(auth)
      where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    end

    private

    def create_from_omniauth(auth)
      create(
        :name     => auth["info"]["name"],
        :provider => auth["provider"],
        :uid      => auth["uid"],
      )
    end
  end
end
