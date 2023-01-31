require 'rails_helper'

RSpec.describe User, type: :model do

  it "password and password_confirmation fields need to match" do
    @user = User.new(first_name: "Andy", last_name: "A", password: "123456", password_confirmation: "12345", email:"test@gmail.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
  end

  it "email must be unique " do
    @user1 = User.new(first_name: "Andy", last_name: "A", password: "123456", password_confirmation: "123456", email:"test@gmail.com")
      @user1.save
    @user2 = User.new(first_name: "Andy", last_name: "B", password: "123456", password_confirmation: "123456", email:"Test@gmail.com")
      @user2.save
      expect(@user2.errors.full_messages).to include("Email has already been taken")
  end

  it "email must be required " do
    @user = User.new(first_name: "Andy", last_name: "A", password: "123456", password_confirmation: "123456", email:nil)
      @user.save
      expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it "first name must be required " do
    @user = User.new(first_name: nil, last_name: "A", password: "123456", password_confirmation: "123456", email:"test@gmail.com")
      @user.save
      expect(@user.errors.full_messages).to include("First name can't be blank")
  end


  it "last name must be required " do
    @user = User.new(first_name: "Andy", last_name: nil, password: "123456", password_confirmation: "123456", email:"test@gmail.com")
      @user.save
      expect(@user.errors.full_messages).to include("Last name can't be blank")
  end

  it "The password must have a minimum length when a user account is being created." do
    @user = User.new(first_name: "Andy", last_name: "A", password: "12345", password_confirmation: "12345", email:"test@gmail.com")
      @user.save
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
  end

  it "password_confirmation is missing" do
    @user = User.new(first_name: "Andy", last_name: "A", password: "123456", password_confirmation: nil, email: "test@gmail.com")
    @user.save
    expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
  end
  

  describe '.authenticate_with_credentials' do
    
  it "should log in successfully if credentials match" do 
    @user = User.new(first_name: "Andy", last_name: "A", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("test@gmail.com", "123456")).to be_present
  end

  it "should be unable to log in for incorrect password" do 
    @user = User.new(first_name: "Andy", last_name: "A", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("test@gmail.com", "123")).not_to be_present
  end

  it "should be unable to log in for incorrect email" do 
    @user = User.new(first_name: "Andy", last_name: "A", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
      @user.save!
      expect(User.authenticate_with_credentials("test1@gmail.com", "123456")).not_to be_present
  end

  it "should log the user in even if there is space" do
    @user = User.new(first_name: "Andy", last_name: "A", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
    @user.save!
    expect(User.authenticate_with_credentials("  test@gmail.com   ", "123456")).to be_present
  end

  it 'should log the user in even incorrect case for email' do
    @user = User.new(first_name: "Andy", last_name: "A", email: "test@gmail.com", password: "123456", password_confirmation: "123456")
    @user.save!
    expect(User.authenticate_with_credentials("teSt@GMAIL.coM", "123456")).to be_present
  end

  end
end
