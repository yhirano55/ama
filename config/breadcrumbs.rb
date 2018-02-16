crumb :root do
  link t("shared.home"), root_path
end

crumb :resources do |klass_or_model|
  link t("#{klass_or_model.model_name.route_key}.index.title"), klass_or_model
end

crumb :new_resource do |model|
  link t("shared.new"), model
  parent :resources, model
end

crumb :resource do |model|
  link "#{model.class.human_attribute_name(model.class.primary_key)}: #{model.to_key.join}", model
  parent :resources, model.class
end

crumb :edit_resource do |model|
  link t("shared.edit"), [:edit, model]
  parent :resource, model
end
