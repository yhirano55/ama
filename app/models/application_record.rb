class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :oldest, -> { order(id: :asc)  }
  scope :newest, -> { order(id: :desc) }
end
