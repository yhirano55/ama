module MentionFilter
  IGNORED_PARENT_NAMES = %w[code pre a style blockquote].freeze
  PATTERN = %r{(?:^|\W)@((?>[\w][\w-]{0,30}\w))(?!\/)(?=\.+[ \t\W]|\.+$|[^0-9a-zA-Z_.]|$)}.freeze

  def mention_link_filter(document)
    doc = Nokogiri::HTML::DocumentFragment.parse(document)

    doc.search(".//text()").each do |node|
      next unless node.content.include?("@")
      next if node.parent.name.in?(IGNORED_PARENT_NAMES)

      node.replace node_with_github_link(node.content)
    end

    doc.to_html
  end

  private

    def node_with_github_link(content)
      content.gsub(PATTERN) do |match|
        name = Regexp.last_match(1)
        match.sub("@#{name}", %(<a href="https://github.com/#{name}">@#{name}</a>))
      end
    end
end
