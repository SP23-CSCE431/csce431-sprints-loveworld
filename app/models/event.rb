class Event < ApplicationRecord
  has_many :event_members, dependent: :destroy

  validates :name, presence: true
  validates :start, presence: true
  validates :end, presence: true
end
