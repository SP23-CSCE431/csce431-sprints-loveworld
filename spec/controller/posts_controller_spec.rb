require 'rails_helper'
require 'capybara/rspec'

RSpec.describe(PostsController, type: :controller) do
  let(:user) { User.create!(email: 'howdy@tamu.edu', full_name: 'Tony Staark', phone_number: '0000000000') }
  let(:post1) { Post.create!(title: 'Finals week', body: 'post body', user_id: user.id) }

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

  it 'creates post' do
    expect { post(:create, params: { post: { title: 'test event', body: 'test description', user_id: user.id } }) }.to(change(Post, :count).by(1))
    expect(response).to(redirect_to(post_url(Post.last.id)))
  end

  it 'shows post' do
    get :show, params: { id: post1.id }
    assert_response :success
  end

  it 'gets edit' do
    get :edit, params: { id: post1.id }
    assert_response :success
  end

  # it 'updates post' do
  #   patch :update, params: { post: { body: post1.body, title: post1.title, user_id: post1.user_id } }
  #   assert_redirected_to post_url(post1.id)
  # end

  # it 'destroys post' do
  #   assert_difference('Post.count', -1) do
  #     delete post_url(post1)
  #   end

  #   assert_redirected_to posts_url
  # end
end
