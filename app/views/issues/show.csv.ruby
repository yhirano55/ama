require 'csv'

CSV.generate do |csv|
  column_names = %w(id author created_at content)
  csv << column_names

  @comments.each do |comment|
    column_values = [
      comment.id,
      display_name(comment),
      comment.created_at,
      comment.content
    ]

    csv << column_values
  end
end
