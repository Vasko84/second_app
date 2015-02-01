module ApplicationHelper
  
  def full_title(page_title)
    common_title="Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      then 
        common_title
      else
        "#{common_title} | #{page_title}"
    end
  end
  
  
  
end
