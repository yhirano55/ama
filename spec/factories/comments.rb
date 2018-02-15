FactoryBot.define do
  factory :comment do
    user nil
    issue nil
    content "MyText"
    likes_count 1
    secret false
  end
end
