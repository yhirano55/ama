require "rails_helper"

RSpec.describe "Comments", type: :system do
  context "admin" do
    let(:user) { create(:user, :admin) }
    let(:issue) { create(:issue) }

    before do
      create(:comment, issue: issue, user: user)
      create_list(:comment, 3, issue: issue)
      authenticate_as user
    end

    it "can read comments in issues#show" do
      visit issue_path(issue)

      issue.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in comments#index" do
      visit comments_path

      Comment.all.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in users#show" do
      visit user_path(user)

      user.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can create a comment" do
      visit issue_path(issue)
      fill_in "comment[content]", with: "new comment"
      click_on I18n.t("helpers.submit.create")

      expect(page).to have_content I18n.t("flash.created", resource: Comment.model_name.human)
    end

    it "can edit anyone's comment" do
      comment = issue.comments.where.not(user: user).sample
      visit issue_path(issue)
      find("#edit-comment#{comment.id}").click
      fill_in "comment[content]", with: "update comment"
      click_on I18n.t("helpers.submit.update", model: Comment.model_name.human)

      expect(page).to have_content I18n.t("flash.updated", resource: Comment.model_name.human)
    end

    it "can delete anyone's comment" do
      comment = issue.comments.where.not(user: user).sample
      visit issue_path(issue)
      find("#destroy-comment#{comment.id}").click

      expect(page).to have_content I18n.t("flash.destroyed", resource: Comment.model_name.human)
    end
  end

  context "guest" do
    let(:user) { create(:user, :guest) }
    let(:issue) { create(:issue) }

    before do
      create(:comment, issue: issue, user: user)
      create_list(:comment, 3, issue: issue)
      authenticate_as user
    end

    it "can read comments in issues#show" do
      visit issue_path(issue)

      issue.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in comments#index" do
      visit comments_path

      Comment.all.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in users#show" do
      visit user_path(user)

      user.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can create a comment" do
      visit issue_path(issue)
      fill_in "comment[content]", with: "new comment"
      click_on I18n.t("helpers.submit.create")

      expect(page).to have_content I18n.t("flash.created", resource: Comment.model_name.human)
    end

    it "can edit my comment" do
      comment = issue.comments.where(user: user).sample
      visit issue_path(issue)

      expect(page).to have_selector "#edit-comment#{comment.id}"
    end

    it "cannot edit other's comment" do
      comment = issue.comments.where.not(user: user).sample
      visit issue_path(issue)

      expect(page).not_to have_selector "#edit-comment#{comment.id}"
    end

    it "can destroy my comment" do
      comment = issue.comments.where(user: user).sample
      visit issue_path(issue)

      expect(page).to have_selector "#edit-comment#{comment.id}"
    end

    it "cannot destroy other's comment" do
      comment = issue.comments.where.not(user: user).sample
      visit issue_path(issue)

      expect(page).not_to have_selector "#edit-comment#{comment.id}"
    end
  end

  context "anonymous" do
    let(:issue) { create(:issue) }

    before do
      create_list(:comment, 3, issue: issue)
      visit root_path
    end

    it "can read comments in issues#show" do
      visit issue_path(issue)

      issue.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in comments#index" do
      visit comments_path

      Comment.all.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "can read comments in users#show" do
      user = User.all.sample
      visit user_path(user)

      user.comments.find_each do |comment|
        within ".card-comment#{comment.id}" do
          expect(page).to have_content comment.user.nickname
          expect(page).to have_content comment.content
        end
      end
    end

    it "cannot create a comment" do
      visit issue_path(issue)

      expect(page).not_to have_selector "form#comment-form"
    end

    it "cannot edit anyone's comment" do
      comment = issue.comments.sample
      visit issue_path(issue)

      expect(page).not_to have_selector "#edit-comment#{comment.id}"
    end

    it "cannot destroy anyone's comment" do
      comment = issue.comments.sample
      visit issue_path(issue)

      expect(page).not_to have_selector "#edit-comment#{comment.id}"
    end
  end
end
