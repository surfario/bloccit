require 'spec_helper'

describe Post do 
  describe "vote methods" do

    before do
      @post = post_without_user
      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end
  end  
  
  describe '#up_votes' do
    it "counts the number of votes with value = 1" do
      expect( @post.up_votes ).to eq(3)
    end
  end  

  describe '#points' do
    it "returns the sume of all up and down votes" do
      expect( @post.points ).to eq(1) # 3-2
    end
  end

  describe 'creation' do
    it "generates an automatic up-vote" do
      user = authenticated_user
      post = Post.create(title: 'Post Title', body: 'This is a small post body string', user: user)
      expect( post.up_votes ).to eq(1)
    end
  end          
end

def post_without_user
  post = Post.new(title: 'Post title', body: 'Post bodies must be pretty long.')
  allow(@post).to recieve(:create_vote)
  post.save
  post
end   

def authenticated_user
  email = "email#{rand}@fake.com"
  user = User.new(email: email, password: 'password')
  user.skip_confirmation!
  user.save
  user
end  