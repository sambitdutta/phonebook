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
  
  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render('contacts/shared/'+association.to_s.singularize + "_fields", :f => builder)
    end
    if options[:hidden] == true
      link_to(name, "javascript:void(0);", :onclick => "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")".html_safe, :style => "display:none;", :class => "")
    else
      link_to(name, "javascript:void(0);", :onclick => "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")".html_safe, :class => "")
    end
  end
  
  def link_to_remove_fields(name, f, options = {})
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0);", :class => options[:class])
  end
  
  def present(object, klass = nil)
    klass ||= (object.class.to_s + "Presenter").constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end
  
end
