module ApplicationHelper
  def mark_required(object, attribute)
    '<span class="required">*</span> '.html_safe if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end
end
