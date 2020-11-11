Given /^I am on the $/ do

end

Given /^a room has been created$/ do
  post '/rooms', {:room_name => 'Test', :max_players => 5, :game_type => 'Random', :private => false }
end

Given /^I have entered a valid room code$/ do
  room_code = Room.all.limit(1)[0][:room_code]
  visit rooms_new_join_path
  fill_in 'id', :with => room_code
  click_button 'Join Room'
end

Then /^I should see the room associated with that code$/ do
  expect(page).to have_content("To have someone join this room")
end

Given /^I have entered an invalid room code$/ do
  visit rooms_new_join_path
  fill_in 'id', :with => '777'
  click_button 'Join Room'
end

Then /^I should stay on the same join room page$/ do
  expect(page).to have_content("Join A Game Room")
end

And /^I should see a message telling me the room code was invalid$/ do
  expect(page).to have_content("A room with that code does not exist.")
end