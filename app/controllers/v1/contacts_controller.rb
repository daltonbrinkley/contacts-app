class V1::ContactsController < ApplicationController
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

  def index
    contacts = Contact.all

    search_terms = params["input_first_name"]
    if search_terms
      contacts = contacts.where("first_name ILIKE ?", "%#{search_terms}")
    end

    search_all = params["input_anything"]
    if search_all
      contacts = contacts.where()

    render json: contacts.as_json 
  end

  def create
    contact = Contact.new(
      first_name: params["input_first_name"],
      middle_name: params["input_middle_name"],
      last_name: params["input_last_name"],
      email: params["input_email"],
      phone_number: params["input_phone_number"],
      bio: params["input_bio"]
      )
    if contact.save
      render json: contact.as_json
    else
      render json: {errors: contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    contact_id = params["id"]
    contact = Contact.find_by(id: contact_id)
    render json: contact.as_json
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.first_name = params["input_first_name"] || contact.first_name
    contact.middle_name = params["input_middle_name"] || contact.middle_name
    contact.last_name = params["input_last_name"] || contact.last_name
    contact.email = params["input_email"] || contact.email
    contact.phone_number = params["input_phone_number"] || contact.phone_number
    contact.bio = params["input_bio"] || contact.bio
    if contact.save
      render json: contact.as_json
    else
      render json: {errors: contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    contact_id = params["id"]
    contact = Contact.find_by(id: contact_id)
    contact.destroy
    render json: {message: "Contact deleted!"}
  end

end
