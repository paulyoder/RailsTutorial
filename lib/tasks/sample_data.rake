require "faker"

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task["db:reset"].invoke
    make_users
    make_microposts
    make_relationships
  end

  def make_users
    admin = User.create!(:name => "Paul Yoder",
                 :email => "paulyoder@gmail.com",
                 :password => "password",
                 :password_confirmation => "password")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 6).each do |user|
      50.times do
        user.microposts.create! :content => Faker::Lorem.sentence(5)
      end
    end
  end

  def make_microposts
    User.limit(6).each do |user|
      50.times do
        content = Faker::Lorem.sentence(5)
        user.microposts.create!(:content => content)
      end
    end
  end

  def make_relationships
    users = User.all
    user = users.first
    users[1..50].each { |following| user.follow!(following) }
    users[3..40].each { |follower| follower.follow!(user) }
  end
end
