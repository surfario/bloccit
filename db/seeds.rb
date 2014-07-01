require 'faker'

User.destroy_all
Post.destroy_all
Comment.destroy_all
Topic.destroy_all
# create users
5.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end
users = User.all  

# create topics
15.times do
  Topic.create(
    name:        Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph
  )
end
topics = Topic.all

# create posts
50.times do 
  Post.create(
    user: users.sample,
    topic: topics.sample,
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph
  )  
end

posts = Post.all

# create comments
100.times do
  Comment.create(
    user: users.sample,
    post: posts.sample,
    body: Faker::Lorem.paragraph
  )
end

# create an admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'admin123',
  role:     'admin'
)
admin.skip_confirmation!
admin.save

# create a moderator
moderator = User.new(
  name:     'Moderator User',
  email:    'moderator@example.com',
  password: 'moderator123',
  role:     'moderator'
)
moderator.skip_confirmation!
moderator.save

# create a member
member = User.new(
  name:     'Member User',
  email:    'member@example.com',
  password: 'member123'
)
member.skip_confirmation!
member.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"  
