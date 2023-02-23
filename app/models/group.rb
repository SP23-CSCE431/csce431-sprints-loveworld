class Group < ApplicationRecord
  has_many :group_members, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
