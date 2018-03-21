require "unirest"
require "tty-prompt"
prompt = TTY::Prompt.new

system "clear"

puts "Welcome to the CONTACTS app! Please select an option: "
puts "[login] Login (Create a JSON web token)"
puts "[signup] Sign-up (Create a new user)"
puts "[logout] Logout (Delete the JSON web token)"

input_option = gets.chomp
if input_option == "login"
  # puts "Please enter your email address: "
  # email = gets.chomp
  # password = prompt.mask("Please enter your password: ") 
  response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: "sambrinkley@gmail.com",
        password: "password"
      }
    }
  )
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")
elsif input_option == "signup"
  params = {}
  print "Please enter full name: "
  params["name"] = gets.chomp
  print "Enter your email: "
  params["email"] = gets.chomp
  params["password"] = prompt.mask("What is your password?")
  params["password_confirmation"] = prompt.mask("Please re-enter your new password for verification: ")
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body  

  puts "You have successfully created your account.  Please enter your email address to login: "
  email = gets.chomp
  password = prompt.mask("Please enter your password: ") 
  response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: "#{email}",
        password: "#{password}"
      }
    }
  )
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")
elsif input_option == "logout"
  jwt = ""
  Unirest.clear_default_headers()
end

system "clear"
puts "Your jwt is #{jwt}

"

puts "Choose an option"
# puts "[1] First Contact"
# puts "[2] Second Contact"
# puts "[3] Third Contact"
puts "[4] ALL Contacts"
puts "[4.1] Search Contacts by First Name"
puts "[4.2] Search all Contacts by attributes"
puts "[5] Create a new contact!" 
puts "[6] Find Contact by ID"
puts "[7] Update a contact!"
puts "[8] Delete a contact!"

input_option = gets.chomp
# if input_option == "1"
#   response = Unirest.get("http://localhost:3000/v1/first_contact_url")
#   contact = response.body
#   puts "The info for Contact 1 is: #{contact}"
# elsif input_option == "2"
#   response = Unirest.get("http://localhost:3000/v1/second_contact_url")
#   contact = response.body
#   p contact
# elsif input_option == "3"
#   response = Unirest.get("http://localhost:3000/v1/third_contact_url")
#   contact = response.body
#   puts contact
if input_option == "4"
  response = Unirest.get("http://localhost:3000/v1/contacts")
  contacts = response.body
  puts contacts
elsif input_option == "4.1"
  print "Please enter a first name: "
  first_name_search = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts?input_first_name=#{first_name_search}")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "4.2"
  print "Please enter a search term:  "
  anything_search = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts?input_anything=#{anything_search}")
  contact = response.body
  puts JSON.pretty_generate(contact)
elsif input_option == "5"
  params = {}
  print "Enter contact FIRST name: "
  params["input_first_name"] = gets.chomp
  print "Enter contact MIDDLE name: "
  params["input_middle_name"] = gets.chomp
  print "Enter contact LAST name: "
  params["input_last_name"] = gets.chomp
  print "Enter contact EMAIL: "
  params["input_email"] = gets.chomp
  print "Enter contact PHONE NUMBER: "
  params["input_phone_number"] = gets.chomp
  print "Enter contact BIO: "
  params["input_bio"] = gets.chomp

  response = Unirest.post("http://localhost:3000/v1/contacts", parameters: params)
  contacts = response.body
  if contacts["errors"] 
    puts "Uh oh! Something is wrong!"
    p contacts["errors"]
  else
    puts "Here is your contact info:"
    puts JSON.pretty_generate(contacts)
  end
  
elsif input_option == "6"
  print "Please enter contact ID: "
  id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts/#{id}")
  contact = response.body
  puts JSON.pretty_generate(contact)

elsif input_option == "7"
  print "Please enter contact ID: "
  id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts/#{id}")
  contact = response.body
  params = {}
  print "FIRST name (#{contact["first_name"]}): "
  params["input_first_name"] = gets.chomp
  print "MIDDLE name (#{contact["middle_name"]}): "
  params["input_middle_name"] = gets.chomp
  print "LAST name (#{contact["last_name"]}): "
  params["input_last_name"] = gets.chomp
  print "EMAIL (#{contact["email"]}): "
  params["input_email"] = gets.chomp
  print "PHONE NUMBER (#{contact["phone_number"]}): "
  params["input_phone_number"] = gets.chomp
  print "BIO (#{contact["bio"]}): "
  params["input_bio"] = gets.chomp
  params.delete_if {|_key, value| value.empty? }

  response = Unirest.patch("http://localhost:3000/v1/contacts/#{id}", parameters: params)
  updated_contact = response.body
  if updated_contact["errors"] 
    puts "Uh oh! Something is wrong!"
    p updated_contact["errors"]
  else
    puts "Here is your contact info:"
    puts JSON.pretty_generate(updated_contact)
  end
elsif input_option == "8"
  print "Enter the contact ID of which you would like to delete: "
  contact_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/contacts/#{contact_id}")
  body = response.body
  puts JSON.pretty_generate(body)
end 