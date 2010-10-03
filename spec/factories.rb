Factory.define :user do |user|
  user.name "Paul Yoder"
  user.email "paulyoder@gmail.com"
  user.password "password"
  user.password_confirmation "password"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end
