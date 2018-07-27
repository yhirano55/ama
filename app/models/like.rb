# == Schema Information
#
# Table name: likes
#
#  id            :bigint(8)        not null, primary key
#  user_id       :bigint(8)        not null
#  likeable_type :string           not null
#  likeable_id   :bigint(8)        not null
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

class Like < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates :likeable_type, presence: true, inclusion: { in: %w[Comment Issue] }
  validates :user_id, uniqueness: { scope: [:likeable_type, :likeable_id] }
end
