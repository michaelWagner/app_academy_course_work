require 'addressable/uri'
require 'rest-client'

def create_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s
  begin
    puts RestClient.post(
      url,
      { user: { username: "sdg" } }
    )
  rescue
    raise "unprocessable_entity"
  end
end

def show_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.html'
  ).to_s
  puts RestClient.get(url)
end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json'
  ).to_s
  puts RestClient.patch(url, { user: { username: "ryan|" } })
end

def delete_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/4.json'
  ).to_s
  puts RestClient.delete(url)
end

# p create_user
####################################################################################
####################################################################################

def index_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1.html'
  ).to_s
  puts RestClient.get(url)
end

def create_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json'
  ).to_s
  begin
    puts RestClient.post(
      url,
      { contact: { name: "Nedzzz", email: "bbb", user_id: 2 } }
    )
  rescue
    raise "unprocessable_entity"
  end
end

def show_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1.html'
  ).to_s
  puts RestClient.get(url)
end

def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1.json'
  ).to_s
  puts RestClient.patch(url, { contact: { email: "words@gmail.com" } })
end

def delete_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/3.json'
  ).to_s
  puts RestClient.delete(url)
end

def create_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares.json'
  ).to_s
  begin
    puts RestClient.post(
      url,
      { contact_share: { contact_id: 3, user_id: 1 } }
    )
  rescue
    raise "unprocessable_entity"
  end
end

def destroy_contact_share
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contact_shares/2.json'
  ).to_s
  puts RestClient.delete(url)
end

# p create_contact_share
# p destroy_contact_share

p index_contact
# p create_contact
# p show_contact
# p update_contact
# p delete_contact
