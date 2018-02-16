module ApplicationHelper
  def markdown(text)
    markdown = Redcarpet::Markdown.new(CustomRenderer, autolink: true, tables: true, filter_html: true, fenced_code_blocks: true)
    markdown.render(text).html_safe
  end
end
