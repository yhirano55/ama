class CustomRenderer < Redcarpet::Render::HTML
  include EmojiRenderer
  include MentionFilter

  PROCESS = %i[emojify mention_link_filter].freeze

  def postprocess(document)
    PROCESS.inject(document) do |doc, process|
      public_send(process, doc)
    end
  end
end
