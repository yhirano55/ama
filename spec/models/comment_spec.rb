# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  issue_id    :integer          not null
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

require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "factory" do
    subject { build(:comment) }

    it { is_expected.to be_valid }
  end
end
