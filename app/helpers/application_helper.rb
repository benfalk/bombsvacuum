module ApplicationHelper

  def field_subscription_path(field)
    "http://#{request.host}:8080/field/#{field.id}"
  end

end
