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
  end
end