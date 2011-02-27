# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def sortable(column, title = nil)
    sort_column = params[:sort] ? params[:sort] : column
    country = params[:country]? params[:country] : 'all'
    title ||= column.titleize
    css_class = column == sort_column ? "current #{params[:direction].to_s}_" : nil
    direction = column == sort_column && params[:direction].to_s == "desc" ? "asc" : "desc"
    link_to title, {:sort => column, :direction => direction, :country => country}, {:class => css_class}
  end
end
