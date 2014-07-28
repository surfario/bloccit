require 'spec_helper'

describe Vote do 
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        v = Vote.new(value: 1)
        expect(v.valid?).to eq(true)

        v2 = Vote.new(value: -1)
        expect(v2.valid?).to eq(true)

        bad_v = Vote.new(value: 2)
        expect(bad_v.valid?).to eq(false)
      end
    end
  end
  
  describe 'after_save' do
    it "calls 'Post#update_rank' after save" do
      post = post_without_user
      vote = Vote.new(value: 1, post: post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end          
end

def post_without_user
  post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')
  expect(post).to receive(:create_vote)
  post.save
  post
end 