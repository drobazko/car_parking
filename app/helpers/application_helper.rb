module ApplicationHelper
  def show_schema(parking, type)
    html = []
    html << '<div>'
    @parking.places_by_type(type).each do |p|
      html << '<div class="place'
      html << ' busy' unless p[:place].free?
      html << '">For ' + "<b>#{type.to_s}</b>"
      html << '<br>'
      html << "Car <b>#{p[:place].car.type}</b>" unless p[:place].free?
      html << '<br>'
      html << link_to('free!', free_path(index: p[:index]), remote: true) unless p[:place].free?
      html << '</div>'
    end
    html << '</div>'

    html.join.html_safe
  end
end
