class CustomRenderer < Redcarpet::Render::HTML
  include EmojiRenderer

  def postprocess(document)
    emojify(document)
  end
end
