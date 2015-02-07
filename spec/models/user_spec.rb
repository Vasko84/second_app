require 'spec_helper'

describe User do
  before {@user=User.new(name:"Vas", email:"vas@vas.va", password:"password", password_confirmation:"password")}
  subject { @user}
  
  it {should respond_to(:name)}
  it {should respond_to(:email)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}
  
  it {should be_valid}
  
  describe "when user name is blank" do
    before {@user.name= " "}
    it {should_not be_valid}
  end
  
  describe "when email is blank" do
    before {@user.email=" "}
    it {should_not be_valid}
  end
  
  describe "when name is too long" do
    before {@user.name="a"*51}
    it {should_not be_valid}
  end
  
  describe "when name is too short" do
    before {@user.name="aa"}
    it {should_not be_valid}
  end
  
  describe "when user email is invalid" do
    it "should be invalid" do 
      addresses=%w[@bar.baz woief@bar@baz foo.bar.baz foo_at_bar.baz]
      addresses.each do |i|
        @user.email=i
        expect(@user).not_to be_valid
      end
    end
  end
  
  describe "when user email is valid" do
    it "should be valid" do
      addresses=%w[foo@bar.baz foo.bar@baz.baz a-b_c@bar.baz abc@bar-baz.baz]
      addresses.each do |i|
        @user.email=i
        expect(@user).to be_valid
      end
    end
  end
  
  describe "when user is duplicated" do
    before do
      
      user_duplicated=@user.dup
      user_duplicated.email=@user.email.upcase
      user_duplicated.save
    end
    it {should_not be_valid}
  end
  
  describe "when password is empty" do
    before {@user.password=@user.password_confirmation=" "}
    it {should_not be_valid}
  end
  
  describe "when password does not match confirmation" do
    before {@user.password_confirmation="mismatch"}
    it {should_not be_valid}
  end
  
  describe "authentication" do
    before {@user.save}
    let (:found_user) {User.find_by(email: @user.email)}
    
    describe "with valid password" do
      it {should eq found_user.authenticate(@user.password)}
    end
    
    describe "with invalid password" do
      let (:invalid_authentication) {found_user.authenticate("invalid_pass")}
      it {should_not eq invalid_authentication}
      specify { expect(invalid_authentication).to be_false}
    end
  end
  
  describe "user with too short password" do
    before {@user.password = @user.password_confirmation = "a"*5}
    it {should_not be_valid}
  end
  
end
