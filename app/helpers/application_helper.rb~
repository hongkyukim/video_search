module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end


  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
