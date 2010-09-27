module ApplicationHelper
  def title
    base_title = "Rails Tutorial"
    return (@title.nil?) ? base_title : "#{base_title} | #{title}"
  end
end
