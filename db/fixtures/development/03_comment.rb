(1..15).each do |issue_id|
  Comment.seed do |comment|
    comment.issue_id = issue_id
    comment.user_id  = User.admin.pluck(:id).sample
    comment.content  = Faker::Lorem.paragraph
    comment.secret   = [true, false].sample
  end

  Comment.seed do |comment|
    comment.issue_id = issue_id
    comment.user_id  = User.guest.pluck(:id).sample
    comment.content  = Faker::Lorem.paragraph
    comment.secret   = [true, false].sample
  end
end
