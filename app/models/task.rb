class Task < ApplicationRecord
  validates :title, presence: true

  has_one_attached  :image
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :board
end
