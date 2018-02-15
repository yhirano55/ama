if Rake::Task.task_defined?("db:seed_fu")
  Rake::Task["db:seed"].enhance do
    Rake::Task["db:seed_fu"].invoke
  end
end
