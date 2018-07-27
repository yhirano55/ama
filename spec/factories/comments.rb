# == Schema Information
#
# Table name: comments
#
#  id          :bigint(8)        not null, primary key
#  user_id     :bigint(8)        not null
#  issue_id    :bigint(8)        not null
#  content     :text             not null
#  likes_count :integer          default(0), not null
#  secret      :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_comments_on_issue_id  (issue_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :comment do
    association :user
    association :issue
    content { Faker::Lorem.paragraph }

    trait(:public) { secret false }
    trait(:secret) { secret true  }
  end
end
