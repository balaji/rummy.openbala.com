# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sortable(column, title = nil)
    sort_column = params[:sort] ? params[:sort] : "name"
    sort_direction = params[:direction]? params[:direction] : "asc"
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
end
