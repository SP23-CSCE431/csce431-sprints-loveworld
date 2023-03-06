require 'rails_helper'

RSpec.describe(Post, type: :model) do
  subject(:post) do
    described_class.new(title: 'Example Post',
                        body: 'This is an example post'
                       )
  end

  it 'is valid with valid attributes' do
    user = User.create!(full_name: 'Brandon Longuet', email: 'brandon.longuet@yahoo.com', phone_number: '1234567890')
    post.user_id = user.id
    expect(post).to(be_valid)
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).not_to(be_valid)
  end

  it 'is not valid without a body' do
    post.body = nil
    expect(post).not_to(be_valid)
  end
end
