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

class Issue < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  scope :most_liked, -> { order(likes_count: :desc) }
  scope :most_commented, -> { order(comments_count: :desc) }
  scope :not_secret, -> { where(secret: false) }

  validates :subject,        presence: true, length: { maximum: 128   }
  validates :description,    presence: true, length: { maximum: 50000 }
  validates :comments_count, presence: true
  validates :likes_count,    presence: true
end
