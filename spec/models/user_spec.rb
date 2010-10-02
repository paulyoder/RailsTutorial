require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name => "Paul Yoder",
      :email => "paulyoder@gmail.com",
      :password => 'password',
      :password_confirmation => 'password' 
    }
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

  describe 'password validations' do
    it 'should require a password' do
      User.new(@attr.merge(:password => ''))
        .should_not be_valid
    end

    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => 'other password'))
        .should_not be_valid
    end

    it 'should reject short passwords' do
      User.new(@attr.merge(:password => '12345', :password_confirmation => '12345'))
        .should_not be_valid
    end

    it 'should reject long passwords' do
      long_password = 'a' * 41
      User.new(@attr.merge(:password => long_password, :password_confirmation => long_password))
        .should_not be_valid
    end
  end

  describe 'password encryption' do
    before :each do
      @user = User.create! @attr
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to :encrypted_password
    end

    it 'should not be blank' do
      @user.encrypted_password.should_not be_blank
    end

    it 'should not be the same as password' do
      (@user.encrypted_password == @user.password).should be_false
    end

    describe 'same_password? method' do
      it 'should be true for same passwords' do
        @user.same_password?('password').should be_true
      end

      it 'should be false for different passwords' do
        @user.same_password?('1234567').should be_false
      end
    end

    describe 'authenticate method' do
      it 'should return nil on email/password mismatch' do
        User.authenticate(@attr[:email], 'wrong_password').should be_nil
      end

      it 'should return nil for an email address with no user' do
        User.authenticate('someemail@email.com', @attr[:password]).should be_nil
      end

      it 'should return the user on email/password match' do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end
  end
end
