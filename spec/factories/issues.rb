FactoryBot.define do
  factory :issue do
    user nil
    subject "MyString"
    description "MyText"
    comments_count 1
    likes_count 1
    secret false
  end
end
