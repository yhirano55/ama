module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(CustomRenderer, autolink: true, tables: true, filter_html: true, fenced_code_blocks: true)
    markdown.render(text).html_safe
  end

  def display_name(resource)
    if resource.secret?
      t("shared.anonymous")
    else
      resource.user.nickname
    end
  end

  def display_link(resource)
    if resource.secret?
      "javascript:void(0);"
    else
      polymorphic_path(resource.user)
    end
  end

  def display_image(resource)
    if resource.secret?
      asset_path("anonymous.svg")
    elsif resource.user.image_url
      polymorphic_path(resource.user.avatar)
    else
      asset_path("guest.png")
    end
  end
end
