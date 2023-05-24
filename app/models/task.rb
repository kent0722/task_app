class Task < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 10 }
  validates :description, presence: true, length: { in: 5..300 }
end
