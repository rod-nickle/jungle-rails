require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    
    it 'validates :user, valid: true' do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.save!
      expect(@user).to be_valid
    end

    it 'validates :first_name, presence: true' do
      @user = User.new(
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'validates :last_name, presence: true' do
      @user = User.new(
        first_name: "John",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'validates :email, presence: true' do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'validates :password, presence: true' do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password_confirmation: "password123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'validates :password_confirmation, presence: true' do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it "validates that the password confirmation doesn't match password" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "123password"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "validates that the password is too short (minimum is 8 characters)" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "123",
        password_confirmation: "123"
      )
      @user.validate
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end

    it "validates that the email has already been taken (case-insensitive)" do
      @user1 = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user1.save!
      @user2 = User.new(
        first_name: "John",
        last_name: "Smith",
        email: "JOHN@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user2.validate
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do

    it "returns an authenticated user if the password is valid" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.save!
      expect(@user).to be_valid
      @validated_user = User.authenticate_with_credentials(@user[:email], "password123")

      expect(@validated_user).to eq(@user)
    end

    it "returns nil if the password if NOT valid" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.save!
      expect(@user).to be_valid
      @validated_user = User.authenticate_with_credentials(@user[:email], "wrong_password")

      expect(@validated_user).to eq(nil)
    end

    it "returns an authenticated user if the email has leading or trailing spaces" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.save!
      expect(@user).to be_valid
      @validated_user = User.authenticate_with_credentials("  john@example.com  ", "password123")

      expect(@validated_user).to eq(@user)
    end

    it "returns an authenticated user if the email is in the wrong case" do
      @user = User.new(
        first_name: "John",
        last_name: "Doe",
        email: "john@example.com",
        password: "password123",
        password_confirmation: "password123"
      )
      @user.save!
      expect(@user).to be_valid
      @validated_user = User.authenticate_with_credentials("JOHN@example.com", "password123")

      expect(@validated_user).to eq(@user)
    end
  end
end
