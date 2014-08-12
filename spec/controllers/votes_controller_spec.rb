require 'rails_helper'

describe VotesController do 

  include TestFactories
  include Devise::TestHelpers

  describe '#create' do
    it "adds an up-vote to the post" do
      request.env["HTTP_REFERER"] = '/'
      @user = authenticated_user
      @post = associated_post
      sign_in @user

      expect {
        post( :create, post_id: @post.id, topic_id: @post.topic_id) 
      }.to change{ @post.up_votes }.by 1
    end  
  end
end

# not passing yet
# "No route matches {:action=>"up_vote", :controller=>"votes", :post_id=>"1"}