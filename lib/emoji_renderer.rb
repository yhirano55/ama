require "somemoji"

module EmojiRenderer
  IGNORED_PARENT_NAMES = %w[code pre].freeze

  def emojify(document)
    doc = Nokogiri::HTML::DocumentFragment.parse(document)

    doc.search(".//text()").each do |node|
      next if node.parent.name.in?(IGNORED_PARENT_NAMES)
      node.replace node_with_emoji(node.content)
    end

    doc.to_html
  end

  private

    def node_with_emoji(content)
      Somemoji.emoji_one_emoji_collection.replace_code(content) do |emoji|
        image_path = ActionController::Base.helpers.image_path("emoji/unicode/#{emoji.code_points.join("-")}.png")
        %(<img src="#{image_path}" width="20" height="20" align="absmiddle" class="emoji" alt="" />)
      end
    end
end
