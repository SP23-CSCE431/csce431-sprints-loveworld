require 'rails_helper'

RSpec.describe(User) do
  subject(:user) do
    described_class.new(full_name: 'Brandon Longuet',
                        email: 'brandon.longuet@yahoo.com',
                        phone_number: '1234567890'
                       )
  end

  it 'is valid with valid attributes' do
    user.full_name = 'Anything'
    user.email = 'Anything'
    user.phone_number = 'Anything'
    expect(user).to(be_valid)
  end

  it 'is not valid without a name' do
    user.full_name = nil
    expect(user).not_to(be_valid)
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to(be_valid)
  end

  it 'is not valid without a phone number' do
    user.phone_number = nil
    expect(user).not_to(be_valid)
  end
end
