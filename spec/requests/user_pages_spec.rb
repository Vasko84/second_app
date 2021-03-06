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
           fill_in "Email", with: "user@example.com"
          fill_in "Password", with: "password"
          fill_in "Confirmation", with: "password"
        end     
      it "should create a user " do
        expect {click_button submit}.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        
        it {should have_link("Sign out")}
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
    
    describe "errors in registration" do
      describe "blank field" do
      before {click_button submit}
      it {should have_content("error")}
      it {should have_content("Name can't be blank")}
      it {should have_content("Email can't be blank")}
      it {should have_content("Password can't be blank")}
      end
      
      describe "short/invalid fields" do
        before do
          fill_in "Name", with:"A"
          fill_in "Email", with:"B"
          fill_in "Password", with:"123"
          fill_in "Confirmation", with:"124"
          click_button submit
        end
        it {should have_content("Name is too short")}
        it {should have_content("Email is invalid")}
        it {should have_content("Password is too short")}
        it {should have_content("Password confirmation doesn't match Password")}
      end
      
      describe "long name" do
        before do
          fill_in "Name", with:"a"*51
          click_button submit
        end
        it {should have_content("Name is too long")}
      end
    end
  end

  describe "Profile pages" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
  
    it {should have_title(user.name)}
    it {should have_content(user.name)}
  end
  
  describe "Edit pages" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page" do
      it {should have_title("Edit user")}
      it {should have_content("Update your profile")}
      it {should have_link("change", href: 'http://gravatar.com/emails')}
    end
    
    describe "with invalid information" do
      before {click_button "Save changes"}
      it {should have_content("error")}
    end
    
    describe "with valid information" do
      let(:new_name) {"NewName"}
      let(:new_email) {"new@exmple.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm", with: user.password
        click_button "Save changes"
      end
      
      it {should have_title(new_name)}
      it {should have_selector("div.alert.alert-success")}
      it {should have_link("Sign out")}
      specify {expect(user.reload.name).to eq new_name}
      specify {expect(user.reload.email).to eq new_email}
    end
    
    describe "invalid attributes" do
      let(:params) do 
        {user: {admin: true, password: user.password, password_confirmation: user.password}}
      end
      before do
        sign_in user, no_capybara: true
        patch user_path(user), params
      end
      specify {expect(user.reload).not_to be_admin}
    end
            
  end
  
  describe "index page" do
    before do
      r_user=FactoryGirl.create(:user)
      sign_in r_user
      FactoryGirl.create(:user, name: "Bob", email: "B@B.B")
      FactoryGirl.create(:user, name: "Any", email: "A@A.a")
      visit users_path
    end
    
    it {should have_title("All users")}
    it {should have_content("All users")}
    
    describe 'Pagination' do
      before(:all) { 30.times {FactoryGirl.create(:user) } }
      after(:all) {User.delete_all}
      
      it {should have_selector('div.pagination')}
      
      it 'should list each user' do
        User.paginate(page:1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end
    
    describe "Delete link" do
      it {should_not have_link("Delete")}
      
      describe "for admin users" do
        let(:admin) {FactoryGirl.create(:admin)}        
        before do
          sign_in admin
          visit users_path
        end
        
        it {should have_link("delete")}
        it {should_not have_link("delete", href:user_path(admin))}
      end
    end
  end
end
