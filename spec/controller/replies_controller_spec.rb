require 'rails_helper'
require 'capybara/rspec'

RSpec.describe(RepliesController, type: :controller) do
  let(:user) { User.create!(email: 'howdy@tamu.edu', full_name: 'Tony Staark', phone_number: '0000000000') }
  let(:post) { Post.create!(title: 'Finals week', body: 'post body', user_id: user.id) }

  let(:reply) { Reply.create!(body: 'reply body', user_id: user.id, post_id: post.id) }

  before do
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]

    allow(request.env['warden']).to(receive(:authenticate!).and_return(user))
    allow(controller).to(receive(:current_admin).and_return(user))

    default_url_options[:host] = 'test.host'
  end

  it 'gets index' do
    get :index
    expect(response).to(render_template(:index))
  end

  it 'gets new' do
    get :new
    expect(response).to(render_template(:new))
  end

  # it 'creates reply' do
  #   expect { post :create, params: { reply: { body: 'test body', user_id: user.id, post_id: post.id } } }.to(change(Reply, :count).by(1))
  #   expect(response).to(redirect_to(reply_url))
  # end

  it 'shows reply' do
    get :show, params: { id: reply.id }
    assert_response :success
  end

  it 'gets edit' do
    get :edit, params: { id: reply.id }
    assert_response :success
  end

  # it 'updates reply' do
  #   patch reply_url(@reply), params: { reply: { body: @reply.body, post_id: @reply.post_id, user_id: @reply.user_id } }
  #   assert_redirected_to reply_url(@reply)
  # end

  # it 'destroys reply' do
  #   assert_difference('Reply.count', -1) do
  #     delete reply_url(@reply)
  #   end

  #   assert_redirected_to replies_url
  # end
end
