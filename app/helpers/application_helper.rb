module ApplicationHelper
  def page_title
    base_title = "Rails Tutorial"
    return (@title.nil?) ? base_title : "#{base_title} | #{@title}"
  end

  def logo_image
    image_tag 'logo.png', :alt => 'Sample App', :class => 'round'
  end
end
