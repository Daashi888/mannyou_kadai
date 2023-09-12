class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :sort_limit, -> {reorder(closing: :desc)}
end
