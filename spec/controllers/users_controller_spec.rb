require 'rails_helper'

RSpec.describe UsersController do
  describe 'Creating a New Account' do
    # before(:all) do
    #   expect(User).to receive(:create!)
    # end
    it 'Should create a new account if provided valid info' do
      # Valid
      test_params = { user: { user_id: 'kev', password: 'asdf123', password_confirmation: 'asdf123',
                              email: 'me@google.com', email_confirmation: 'me@google.com' } }
      post :create, test_params
      expect(response).to redirect_to(login_path)
    end
    it 'password must be 7-20 characters, have letter+number and a confirmation' do

      # Invalid
      test_params = { user: {user_id: 'kev', password: '12345', password_confirmation: '12345',
                             email: 'me@google.com', email_confirmation: 'me@google.com' } }
      post :create, test_params
      expect(response).to redirect_to(new_user_path)
    end
    it 'Password must be confirmed' do
      # Valid
      test_params = { user: { user_id: 'kev', password: 'asdf123',
                              email: 'me@google.com', email_confirmation: 'me@google.com' } }
      post :create, test_params
      expect(response).to redirect_to(new_user_path)
    end
    it 'Email must be confirmed' do

      # Invalid
      test_params = { user: {user_id: 'kev', password: 'asdf123', password_confirmation: 'asdf123',
                             email: 'me@google.com' } }
      post :create, test_params
      expect(response).to redirect_to(new_user_path)
      expect(flash[:notice]).to_not be_nil
    end
  end

end
