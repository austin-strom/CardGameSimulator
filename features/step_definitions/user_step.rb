Before do |scenario|
  User.delete_all
  Capybara.server = :webrick

end
After do
  User.delete_all
  Capybara.use_default_driver
  Capybara.server = :puma

end

Given /^I am on the "(.*?)" page$/ do |arg1|
  visit new_user_path if arg1.to_s.include? "signup"
end

Given /^I have create an account with username "(.*?)", email "(.*?)", and password "(.*?)"$/ do |user_id, email, pass|
  visit new_user_path
  fill_out_signup(user_id, email, pass)
end

When /^I create an account with username "(.*?)", email "(.*?)", and password "(.*?)"$/ do |user_id, email, pass|
  fill_out_signup(user_id, email, pass)
end

When /^I attempt to login with "(.*?)" and "(.*?)"$/ do |email, pass|
  x=page.html
  fill_in 'loginPass', :with => pass
  fill_in 'loginEmail', :with => email
  click_button 'Login to my account'
end

Then /^I should be redirected to the "(.*?)" page$/ do |arg1|
  x = page.html
  expect(page).to have_content('Dashboard') if arg1.to_s.include? "dashboard"
  expect(page.has_button?('login_submit')).to be_truthy if arg1.to_s.include? "login"

end

And /^Javascript is enabled$/ do
  Capybara.current_driver = Capybara.javascript_driver
  visit dashboard_path
  click_button 'Sign Up/Login'
  expect(page).to have_content('Dashboard')
end

And /^I should be able to logout$/ do
  click_button 'Logout'
  expect(page.has_button?('signupLogin')).to be_truthy

end

private

def fill_out_signup(user_id, email, pass)
  x = page.html
  fill_in 'signupUser', :with => user_id
  fill_in 'signupPass', :with => pass
  fill_in 'signupPassConfirm', :with => pass
  fill_in 'signupEmail', :with => email
  fill_in 'signupEmailConfirm', :with => email
  click_button 'Create Account'
end