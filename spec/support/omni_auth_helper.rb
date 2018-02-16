module OmniAuthHelper
  def prepare_mock_auth_from(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      "provider" => "github",
      "uid"      => user.uid,
      "info" => {
        "image"    => user.image_url,
        "nickname" => user.nickname,
      },
    )
  end

  def authenticate_as(user)
    prepare_mock_auth_from(user)
    visit root_path
    click_link I18n.t("shared.login")
  end
end
