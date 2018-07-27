# == Schema Information
#
# Table name: users
#
#  id             :bigint(8)        not null, primary key
#  uid            :integer          not null
#  nickname       :string           not null
#  image_url      :string
#  role           :integer          default("guest"), not null
#  comments_count :integer          default(0), not null
#  likes_count    :integer          default(0), not null
#  remember_token :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_users_on_remember_token  (remember_token) UNIQUE
#  index_users_on_uid             (uid) UNIQUE
#

class User < ApplicationRecord
  enum role: { guest: 0, admin: 1, banned: 2 }
  alias_method :ban!, :banned!

  has_one_attached :avatar

  has_many :issues,   dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy

  validates :uid,            presence: true, uniqueness: true
  validates :nickname,       presence: true
  validates :role,           presence: true
  validates :comments_count, presence: true
  validates :likes_count,    presence: true

  before_create :set_remember_token
  before_save :upload_avatar_from_image_url, if: :image_url_changed?

  def upload_avatar_from_image_url
    return if image_url.nil?

    open(image_url) do |io|
      self.avatar = ActiveStorage::Blob.create_after_upload!(
        io: io,
        filename: File.basename(image_url),
        content_type: io.content_type,
      )
    end
  end

  private

    def set_remember_token
      self.remember_token = generate_remember_token
    end

    def generate_remember_token
      SecureRandom.hex(20)
    end
end
