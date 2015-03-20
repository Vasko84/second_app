FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Vasko #{n}"}
    sequence(:email) { |n| "vas#{n}@vas.vas"}
    password "123456"
    password_confirmation "123456"
    factory :admin do
      admin true
    end
  end
end
