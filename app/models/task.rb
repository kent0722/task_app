class Task < ApplicationRecord
  belongs_to :user
  
  validates :create_at, presence: true
  validates :description, length: { maximum: 150 }
end
