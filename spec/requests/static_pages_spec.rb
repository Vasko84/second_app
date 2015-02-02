require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Second App'" do
      visit '/static_pages/home'
      expect(page).to have_content('Second App')
    end
    
    it "should have title 'RoR'" do
      visit '/static_pages/home'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end
    
    it "should not have 'Home' in title" do
      visit '/static_pages/home'
      expect(page).not_to have_title("Home")
    end
        
  end
  
  describe "Help page" do
    
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have title 'RoR | Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end    
    
  end
  
  describe "About page" do
    
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Me')
    end
    
    it "should have title 'RoR | About'" do
      visit '/static_pages/about'
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
    end   
    
  end
  
  describe "Contact page" do
    
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact')
    end
    
    it "should have title RoR | Contact" do
      visit '/static_pages/contact'
      expect(page).to have_title('Ruby on Rails Tutorial Sample App | Contact')
    end
  end
  
end
