class Event < ApplicationRecord
  has_many :event_members, dependent: :destroy
end
