module ApplicationHelper
  
  # Returns the fukk title on a per-page basis.
  def full_title(page_title = "")
    base_title = "Francesco Sample App"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
