require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid when all inputs are filled' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')
      @user.save
      expect(@user).to be_valid
      expect(@user.errors.full_messages).to be_empty
    end
    it 'is invalid when email provided is already registered - case sensitive' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')
      @user.save!
      @new_user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'POTTER@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')  
      @new_user.save
      expect(@new_user.errors.full_messages).not_to be_empty
      expect(@new_user).to_not be_valid
    end
    it 'is invalid if password below minimum length' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Gin', password_confirmation: 'Gin')
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
    it 'is invalid if first name not filled in' do
      @user = User.new(first_name: nil, last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')      
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
    it 'is invalid if last name not filled in' do
      @user = User.new(first_name: 'Harry', last_name: nil, email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')      
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
    it 'is invalid if email not filled in' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: nil, password: 'Ginny123', password_confirmation: 'Ginny123')      
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
    it 'is invalid if password not filled in' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: nil, password_confirmation: nil)      
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
    it 'is invalid if email and email confirmation dont match' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny1234')      
      @user.save
      expect(@user.errors.full_messages).not_to be_empty
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates when email and password match existing user' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')
      @user.save
      expect(User.authenticate_with_credentials('potter@gryffindor.com', 'Ginny123')).to be == @user
    end 
    it 'authenticates when whitespace or capitalized email and password match existing user' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')
      @user.save
      expect(User.authenticate_with_credentials(' PoTTER@gryffindor.com', 'Ginny123')).to be == @user
    end 
    it 'does not authenticate when email and password do not match existing user' do
      @user = User.new(first_name: 'Harry', last_name: 'Potter', email: 'potter@gryffindor.com', password: 'Ginny123', password_confirmation: 'Ginny123')
      @user.save
      expect(User.authenticate_with_credentials('malfoy@gryffindor.com', 'Ginny123')).to_not be == @user
    end 
  end
end