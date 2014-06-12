class ProfileDecorator < Draper::Decorator
  delegate_all

  def real_name
    if object.real_name.present?
      object.real_name
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  def birthday
    if object.birthday.present?
      object.birthday.strftime("%d.%m.%Y")
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
