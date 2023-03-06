class User < ApplicationRecord
  has_many :group_members, dependent: :destroy
  has_many :event_members, dependent: :destroy

  validates :full_name, presence: true
end
