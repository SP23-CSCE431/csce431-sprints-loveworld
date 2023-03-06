require 'rails_helper'

RSpec.describe(Reply, type: :model) do
  subject(:reply) do
    described_class.new(body: 'This is an example reply')
  end

  it 'is valid with valid body' do
    user = User.create!(full_name: 'Brandon Longuet', email: 'brandon.longuet@yahoo.com', phone_number: '1234567890')
    post = Post.create!(title: 'Example Post', body: 'This is an example post', user_id: user.id)
    reply.user_id = user.id
    reply.post_id = post.id
    expect(reply).to(be_valid)
  end

  it 'is not valid without a body' do
    reply.body = nil
    expect(reply).not_to(be_valid)
  end
end
