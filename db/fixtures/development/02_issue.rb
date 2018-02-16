(1..30).each do |_issue_id|
  Issue.seed do |issue|
    issue.user_id     = User.admin.pluck(:id).sample
    issue.subject     = Faker::Lorem.sentence
    issue.description = Faker::Lorem.paragraph
    issue.secret      = [true, false].sample
  end

  Issue.seed do |issue|
    issue.user_id     = User.guest.pluck(:id).sample
    issue.subject     = Faker::Lorem.sentence
    issue.description = Faker::Lorem.paragraph
    issue.secret      = [true, false].sample
  end
end
