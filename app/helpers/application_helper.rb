module ApplicationHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end
end
