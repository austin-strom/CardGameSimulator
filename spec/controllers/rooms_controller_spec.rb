require 'spec_helper'
require 'rails_helper'

describe RoomsController do

  before(:all) do
    User.delete_all
    @user = FactoryBot.create(:user)
  end

  describe 'creating a new room' do
    it 'should successfully create a new room' do
      post :create, params: {room_name: 'Test', max_players: 5, game_type: 'Random', private: false },
          session: {session_token: @user.session_token}
      expect(flash[:notice].include?('Welcome to your newly created room')).to be_truthy
      expect(Room.all.count).to eq(1)
      expect(Room.find(1).name).to eq('Test')
    end
    it 'should redirect to the new created room' do
      post :create, params: {room_name: 'Test'}, session: {session_token: @user.session_token}
      expect(response).to redirect_to('/rooms/1')
      #TODO: Figure out how to change to a path variable
    end
    it 'should go back to login page if not logged in' do
      post :create, params: {room_name: 'Test'}
      # byebug
      expect(response).to redirect_to(dashboard_path)
    end
  end
  describe 'joining a new room' do
    before(:each) do
      allow(SecureRandom).to receive(:random_number).and_return(1111111111)
      post :create, params: {room_name: "Dan's Test Room", max_players: 1}, session: {session_token: @user.session_token}
    end
    it 'should redirect to the room page corresponding to the valid id given' do

      post :create_join, params: {id: 1111111111}
      # byebug
      expect(response).to redirect_to('/rooms/1')
    end
    it 'should redirect to the join room page if invalid id is given' do
      post :create_join, params: {id: 1111111110}
      # byebug
      expect(response).to redirect_to('/rooms/new_join')
    end
    it 'should flash a warning if an invalid id is given' do
      post :create_join, params: {id: 1111111110}
      # byebug
      expect(flash[:warning]).to eq("A room with that code does not exist.")
    end
    describe 'joining a full room' do
      before(:each) do
        post :create_join, params: {id: 1111111111}
        @user2 = FactoryBot.create(:user, :email => 'you@you.com', :email_confirmation => 'you@you.com')
        @controller.send(:clear_current_user)
        post :create_join, params: {id: 1111111111}, session: {session_token: @user2.session_token}
      end
      it 'should not let a user join a room if the room is full' do
        room = Room.find_by_name("Dan's Test Room")
        expect(room.users).not_to include(@user2)
      end
      it 'should redirect to the dashboard page if a user tries to join a full room' do
        expect(response).to redirect_to '/dashboard'
      end
      it 'the dashboard page should flash a warning if the room a user tried to join was full' do
        expect(flash[:notice]).to eq("Sorry, Dan's Test Room is already at full capacity")
      end
    end
    describe 'on successfully joining a room for the first time' do
      before(:each) do
        @room = Room.find_by_name("Dan's Test Room")
        @room.max_players = 2
        @room.save
        @user2 = FactoryBot.create(:user, :email => 'you@you.com', :email_confirmation => 'you@you.com')
        @user2.user_id = "dan"
        @user2.save
        @controller.send(:clear_current_user)
        post :create_join, params: {id: 1111111111}, session: {session_token: @user2.session_token}
      end
      it 'should add the user to the room' do
        expect(@room.users).to include(@user2)
      end
      it 'should create a pile belonging to the room for the user\'s hand' do
        pile = Pile.find_by_creator("dan")
        expect(@room.piles).to include(pile)
      end
      it 'should redirect to the room\'s page' do
        expect(response).to redirect_to('/rooms/1')
      end
      it 'should display a flash message on the room page welcoming the user to the room' do
        expect(flash[:notice]).to eq("#{@user2.user_id}, welcome to #{@room.name}")
      end
    end
  end
  describe 'RoomsController#show' do
    it 'should use the id parameter to assign the correct room to @rooms, making the room available to the view' do
      allow(SecureRandom).to receive(:random_number).and_return(1111111111)
      post :create, params: {room_name: "Dan's Test Room", max_players: 1}, session: {session_token: @user.session_token}
      get :show, params: {id: 1}
      expect(assigns(:room)).to eq(Room.find_by_id(1))
    end
  end
end
