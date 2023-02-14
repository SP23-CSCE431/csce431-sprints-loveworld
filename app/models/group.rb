class Group < ApplicationRecord
  has_many :group_members

  validates :name, presence: true
  validates :description, presence: true
end
