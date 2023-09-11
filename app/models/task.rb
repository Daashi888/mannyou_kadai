class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :old, -> {order(created_at: :asc)}
end
