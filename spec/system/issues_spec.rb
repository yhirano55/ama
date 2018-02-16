require "rails_helper"

RSpec.describe "Issues", type: :system do
  context "admin" do
    let(:user) { create(:user, :admin) }

    before do
      create_list(:issue, 3)
      authenticate_as user
    end

    it "can read issues" do
      Issue.all.find_each do |issue|
        within "tr.table-row-issue#{issue.id}" do
          expect(page).to have_selector "td.col-subject", text: issue.subject
        end
      end
    end

    it "can create an issue" do
      click_link I18n.t("issues.new.title", resource: Issue.model_name.human)
      fill_in "issue[subject]",     with: "my subject"
      fill_in "issue[description]", with: "my description"
      click_on I18n.t("helpers.submit.create")

      expect(page).to have_content I18n.t("flash.created", resource: Issue.model_name.human)
      expect(page).to have_selector "h1",         text: "my subject"
      expect(page).to have_selector ".author",    text: user.nickname
      expect(page).to have_selector ".card-body", text: "my description"
    end

    it "can read an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)

      expect(page).to have_selector "h1", text: issue.subject

      within ".card-issue#{issue.id}" do
        expect(page).to have_selector ".author",    text: issue.user.nickname
        expect(page).to have_selector ".card-body", text: issue.description
      end
    end

    it "can edit an issue" do
      issue = Issue.all.sample
      visit edit_issue_path(issue)
      fill_in "issue[subject]",     with: "my subject"
      fill_in "issue[description]", with: "my description"
      click_on I18n.t("helpers.submit.update", model: Issue.model_name.human)

      expect(page).to have_content I18n.t("flash.updated", resource: Issue.model_name.human)
      expect(page).to have_selector "h1", text: "my subject"
      expect(page).to have_selector ".author",    text: issue.user.nickname
      expect(page).to have_selector ".card-body", text: "my description"
    end

    it "can delete an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)
      find("#destroy-issue#{issue.id}").click

      expect(page).to have_content I18n.t("flash.destroyed", resource: Issue.model_name.human)
    end
  end

  context "guest" do
    let(:user) { create(:user, :guest) }

    before do
      create_list(:issue, 3)
      authenticate_as user
    end

    it "can read issues" do
      Issue.all.find_each do |issue|
        within "tr.table-row-issue#{issue.id}" do
          expect(page).to have_selector "td.col-subject", text: issue.subject
        end
      end
    end

    it "cannot create an issue" do
      expect(page).not_to have_content I18n.t("issues.new.title", resource: Issue.model_name.human)
    end

    it "cannot edit an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)
      expect(page).not_to have_selector "#edit-issue#{issue.id}"
    end

    it "cannot delete an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)
      expect(page).not_to have_selector "#destroy-issue#{issue.id}"
    end
  end

  context "anonymous" do
    before do
      create_list(:issue, 3)
      visit root_path
    end

    it "can read issues" do
      Issue.all.find_each do |issue|
        within "tr.table-row-issue#{issue.id}" do
          expect(page).to have_selector "td.col-subject", text: issue.subject
        end
      end
    end

    it "cannot create an issue" do
      expect(page).not_to have_content I18n.t("issues.new.title", resource: Issue.model_name.human)
    end

    it "cannot edit an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)
      expect(page).not_to have_selector "#edit-issue#{issue.id}"
    end

    it "cannot delete an issue" do
      issue = Issue.all.sample
      visit issue_path(issue)
      expect(page).not_to have_selector "#destroy-issue#{issue.id}"
    end
  end
end
