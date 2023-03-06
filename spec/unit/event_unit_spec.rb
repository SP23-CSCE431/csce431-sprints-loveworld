require 'rails_helper'

RSpec.describe(Event, type: :model) do
  subject(:event) do
    described_class.new(name: 'Brandon Longuet',
                        start: Time.now.utc,
                        end: Time.now.utc + 3.days
                       )
  end

  it 'is valid with valid attributes' do
    event.name = 'Anything'
    event.start = Time.now.utc
    event.end = Time.now.utc + 3.days
    expect(event).to(be_valid)
  end

  it 'is not valid without attributes' do
    event.name = nil
    event.start = nil
    event.end = nil
    expect(event).not_to(be_valid)
  end
end
