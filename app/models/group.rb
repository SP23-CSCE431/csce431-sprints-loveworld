class Group < ApplicationRecord
  has_many :group_members, dependent: :destroy
end
