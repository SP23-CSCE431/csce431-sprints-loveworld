class User < ApplicationRecord
  has_many :group_members
  has_many :event_members

  validates :full_name, presence: true
end
