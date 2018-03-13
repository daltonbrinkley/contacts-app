class Contact < ApplicationRecord

  def friendly_updated_at
    updated_at.strftime("%B%e, %Y")
  end

  def full_name
    full_name = "#{first_name} #{last_name}"
  end

  def japanese_number
    japanese_number = "+81-#{phone_number}"
  end

  def as_json
    {
    id: id,
    first_name: first_name,
    last_name: last_name,
    email: email,
    phone_number: phone_number,
    updated_at: friendly_updated_at,
    full_name: full_name,
    japanese_number: japanese_number
    }
  end
end
