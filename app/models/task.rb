class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :sort_limit, -> {reorder(closing: :desc)}
  scope :sort_priority, -> {reorder(priority: :asc)}

  scope :name_search, -> (name){where('title LIKE ?' , "%#{name}%")}
  scope :status_search, -> (p_status){where(status: p_status)}
  
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  belongs_to :user
end
