require "rails_helper"

RSpec.describe "Authentication", type: :system do
  let(:user) { build(:user) }

  it "login" do
    authenticate_as(user)
    expect(page).to have_content I18n.t("flash.logged_in")
  end

  it "logout" do
    authenticate_as(user)
    find("#navbarDropdown").click
    click_link I18n.t("application.navbar.logout")
    expect(page).to have_content I18n.t("flash.logged_out")
  end
end
