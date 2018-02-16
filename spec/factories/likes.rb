# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  likeable_type :string           not null
#  likeable_id   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_likes_for_uniqueness                    (user_id,likeable_type,likeable_id) UNIQUE
#  index_likes_on_likeable_type_and_likeable_id  (likeable_type,likeable_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :like do
    association :user
    association :likeable, factory: :issue
  end
end
