require 'spec_helper'

describe "User Pages" do
  
  subject {page}
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  
  describe "GET /user_pages" do
    before {visit signup_path}
    
    it {should have_content('SignUp')}
    it {should have_title("#{base_title} | SignUp")}
  end

  describe "Profile pages" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit user_path(user)}
  
    it {should have_title(user.name)}
    it {should have_content(user.name)}
  end
  
  
end
