require "rails_helper"

RSpec.describe "Likes", type: :system do
  context "logged in user" do
    let(:user)  { create(:user) }
    let(:issue) { create(:issue) }

    before do
      create(:comment, issue: issue)
      authenticate_as user
      click_link issue.subject
    end

    it "can create a like" do
      expect(page).to have_selector "span[data-controller='like']"
    end

    it "can destroy a like" do
      expect(page).to have_selector "span[data-controller='like']"
    end
  end

  context "anonymous" do
    let(:issue) { create(:issue) }

    before do
      create(:comment, issue: issue)
      visit issue_path(issue)
    end

    it "cannot create a like" do
      expect(page).not_to have_selector "span[data-controller='like']"
    end

    it "cannot destroy a like" do
      expect(page).not_to have_selector "span[data-controller='like']"
    end
  end
end
