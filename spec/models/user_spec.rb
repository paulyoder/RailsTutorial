require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { :name => "Paul Yoder", :email => "paulyoder@gmail.com" }
  end

  it 'should create a new instance given valid attributes' do
    User.create! @attr
  end

  it 'should require a name' do
    no_name_user = User.new(@attr.merge(:name => ''))
    no_name_user.should_not be_valid
  end

  it 'should require an email address' do
    no_email_user = User.new(@attr.merge(:email => ''))
    no_email_user.should_not be_valid
  end

  it 'should reject long names' do
    long_name = 'a' * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  def new_user_email(email)
    User.new(@attr.merge!(:email => email))
  end

  it 'should accept valid email addresses' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |a|
      valid_email_user = new_user_email a
      valid_email_user.should be_valid
    end
  end

  it 'should not accept invalid email addresses' do
    addresses = %w[user@foo,com user_at_foo.org first.last@foo.]
    addresses.each do |a|
      valid_email_user = new_user_email a
      valid_email_user.should_not be_valid
    end
  end

  it 'should reject duplicate email addresses' do
    User.create! @attr
    duplicate_email_user = User.new @attr
    duplicate_email_user.should_not be_valid
  end

  it 'should reject duplicate email addresses with different cases' do
    User.create! @attr
    upcase_email = @attr[:email].upcase
    duplicate_email_user = new_user_email upcase_email
    duplicate_email_user.should_not be_valid
  end
end
