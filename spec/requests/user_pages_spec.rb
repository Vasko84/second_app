require 'spec_helper'

describe "User Pages" do
  
  subject {page}
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  
  describe "Sign Up page" do
    before {visit signup_path}
    let(:submit) {"Create my account"}
    
    describe "content and title" do
      it {should have_content('SignUp')}
      it {should have_title("#{base_title} | SignUp")}
    end
    
    describe "with invalid information" do
      it "should not create user" do
        expect {click_button submit}.not_to change(User, :count)
      end
    end
   
    describe "with valid information" do
         before do
          fill_in "Name", with: "Example_user"
          fill_in "Email", with: "example@example.com"
          fill_in "Password", with: "password"
          fill_in "Confirmation", with: "password"
        end     
      it "should create a user " do
        expect {click_button submit}.to change(User, :count).by(1)
      end
    end
    
  end

  describe "Profile pages" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
  
    it {should have_title(user.name)}
    it {should have_content(user.name)}
  end
  
  
end
