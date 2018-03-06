
require "unirest"

system "clear"
puts "Choose an option"
puts "[1] First Contact"
puts "[2] Second Contact"
puts "[3] Third Contact"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000//first_contact_url")
  contact = response.body
  puts "The info for Contact 1 is: #{contact}"
elsif input_option == "2"
  response = Unirest.get("http://localhost:3000/second_contact_url")
  contact = response.body
  p contact
elsif input_option == "3"
  response = Unirest.get("http://localhost:3000/third_contact_url")
  contact = response.body
  puts contact
end