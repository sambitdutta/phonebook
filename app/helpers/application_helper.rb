module ApplicationHelper
  # method to handle error messages
  def error_messages_for(object)
    render(partial: 'application/error_messages',
           locals: { object: object }) unless object.blank? || object.errors.count.zero?
  end

  # method to handle form error highlight
  def form_class(object, column)
    if object.errors[column].empty?
      ''
    else
      'has-error'
    end
  end

  # method to handle form error autofocus
  def form_autofocus(object, column)
    if object.errors[column].empty?
      false
    else
      true
    end
  end
end
