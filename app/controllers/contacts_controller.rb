class ContactsController < ApplicationController
  def first_contact_method
    contact = Contact.first
    render json: {
    first_name: contact.first_name,
    last_name: contact.last_name,
    email: contact.email,
    phone_number: contact.phone_number
    }
  end

  def second_contact_method
    contact = Contact.second
    render json: {
    first_name: contact.first_name,
    last_name: contact.last_name,
    email: contact.email,
    phone_number: contact.phone_number
    }
  end

  def third_contact_method
    contact = Contact.third
    render json: {
    first_name: contact.first_name,
    last_name: contact.last_name,
    email: contact.email,
    phone_number: contact.phone_number
    }
  end

end
