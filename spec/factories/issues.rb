# == Schema Information
#
# Table name: issues
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  subject        :string           not null
#  description    :text             not null
#  comments_count :integer          default(0), not null
#  likes_count    :integer          default(0), not null
#  secret         :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_issues_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :issue do
    association :user
    subject     { Faker::Lorem.sentence  }

    description { Faker::Lorem.paragraph }

    trait(:public) { secret false }
    trait(:secret) { secret true  }
  end
end
