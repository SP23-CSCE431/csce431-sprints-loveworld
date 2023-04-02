class User < ApplicationRecord
  has_many :group_members, dependent: :destroy
  has_many :groups, through: :group_members
  has_many :event_members, dependent: :destroy
  has_many :events, through: :event_members
  has_many :posts, dependent: :destroy

  validates :full_name, :email, :phone_number, presence: true
end
