class Post < ApplicationRecord
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
