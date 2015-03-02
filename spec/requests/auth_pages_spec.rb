require 'spec_helper'

describe "AuthPages" do
  subject {page}
  before {visit signin_path}
  
  it {should have_title("Sign in")}
  it {should have_content("Sign in")}
  
  describe "sign in" do
    describe "with invalid information" do
      before {click_button "Sign in"}
    
      it {should have_title("Sign in")}
      it {should have_selector("div.alert.alert-danger")}
      
      describe "after opening new page" do
        before {click_link "Home"}
        it {should_not have_selector("div.alert.alert-danger")}
      end
    end
    
    describe "with valid information" do
      let(:user) {FactoryGirl.create(:user)}
      before {sign_in(user)}
      
      it {should have_title(user.name)}
      it {should have_link("Profile", href: user_path(user))}
      it {should have_link("Settings", href: edit_user_path(user))}
      it {should have_link("Sign out", href: signout_path)}
      it {should_not have_link("Sign in", href: signin_path)}
      
      describe "followed by sign_out" do
        before {click_link("Sign out")}
        
        it {should have_link("Sign in")}
      end
    end
  end
  
  describe "autorization" do
    let(:user) {FactoryGirl.create(:user)}
    describe "for non-signed in users" do
      describe "in controller" do
        describe "visiting edit page" do
          before {visit edit_user_path(user)}
        
          it {should have_title("Sign in")}
        end
      
        describe "sending PATCH" do
          before { put user_path(user) }
          
          specify {expect(response).to eq redirect_to(signin_path)}
        end
      end
    end
  end
end


