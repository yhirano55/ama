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

class Comment < ApplicationRecord
  belongs_to :user
  counter_culture :user, column_name: ->(record) { record.secret? ? nil : "comments_count" }
  belongs_to :issue, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  scope :most_liked, -> { order(likes_count: :desc) }
  scope :not_secret, -> { where(secret: false) }

  validates :content,     presence: true, length: { maximum: 50000 }
  validates :likes_count, presence: true
end
