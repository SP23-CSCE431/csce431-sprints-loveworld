require 'rails_helper'

RSpec.describe(Group, type: :model) do
  reply do
    described_class.new( body: 'This is an example reply'
                       )
  end

  it 'is valid with valid body' do
    reply.body = 'Anything'
    expect(reply).to(be_valid)
  end

  it 'is not valid without a body' do
    reply.body = nil
    expect(reply).not_to(be_valid)
  end
end