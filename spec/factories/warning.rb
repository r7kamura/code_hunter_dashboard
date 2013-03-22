FactoryGirl.define do
  factory :warning do
    sequence(:email) {|id| "#{id}@example.com" }
    sequence(:author) {|id| "author#{id}" }
    sequence(:sha1) {|id| "%040d" % id }
    message { "message" }
    modified_at { Time.now }
    path { "path.rb" }
    line { 1 }
  end
end
