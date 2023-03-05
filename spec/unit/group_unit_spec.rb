require 'rails_helper'

RSpec.describe(Group, type: :model) do
  group do
    described_class.new(name: 'LoveWorld Staff',
                        description: 'This if for the LoveWorld Staff'
                       )
  end

  it 'is valid with valid attributes' do
    group.name = 'Anything'
    group.description = 'Anything'
    expect(group).to(be_valid)
  end

  it 'is not valid without a name and description' do
    group.name = nil
    group.description = nil
    expect(group).not_to(be_valid)
  end
end
