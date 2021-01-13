module ApplicationHelper
  # Returns the full title on per-page basis.
  def full_title page_title
    base_title = t(:title)
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
