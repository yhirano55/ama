require "rails_helper"

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  before do
    create_list(:user, 3)
    authenticate_as user
  end

  it "can read users" do
    visit users_path

    User.all.find_each do |user|
      within "tr.table-row-user#{user.id}" do
        expect(page).to have_selector "td.col-id",       text: user.id
        expect(page).to have_selector "td.col-nickname", text: user.nickname
      end
    end
  end

  it "can read a user" do
    visit user_path(user)

    within "table.attributes_table_for" do
      expect(page).to have_selector "td.col-nickname",       text: user.nickname
      expect(page).to have_selector "td.col-comments_count", text: user.comments_count
      expect(page).to have_selector "td.col-likes_count",    text: user.likes_count
      expect(page).to have_selector "td.col-created_at",     text: I18n.l(user.created_at, format: :long)
      expect(page).to have_selector "td.col-updated_at",     text: I18n.l(user.updated_at, format: :long)
    end
  end
end
