class Contact < ApplicationRecord
  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/

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
    middle_name: middle_name,
    last_name: last_name,
    email: email,
    phone_number: phone_number,
    bio: bio,
    updated_at: friendly_updated_at,
    full_name: full_name,
    japanese_number: japanese_number
    }
  end
end
