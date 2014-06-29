class ProfileDecorator < Draper::Decorator
  delegate_all

  def avatar
    h.image_tag(avatar_name, class: "avatar")
  end

  def real_name
    if object.real_name.present?
      object.real_name
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  def member_since
    model.created_at.strftime("%d.%m.%Y")
  end

  def website
    if object.website.present?
      object.website
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  def location
    if object.location.present?
      object.location
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  def age
    if object.birthday.present?
      a = calc_age(object.birthday)
      "#{a} #{Russian.p(a,'год','года','лет')}"
    else
      h.content_tag :span, 'Не представлено', class: 'none'
    end
  end

  private

  def avatar_name
    if model.avatar.present?
      model.avatar
    else
      "default_user.jpeg"
    end
  end

  def calc_age(birthday)
    now = Time.now.utc.to_date
    now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
