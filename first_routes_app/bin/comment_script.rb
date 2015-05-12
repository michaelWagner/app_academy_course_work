require 'addressable/uri'
require 'rest-client'

def create_user_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1/comments.json'
  ).to_s
  begin
    puts RestClient.post(
      url,
      { comment: { commentable_id: 2, author_id: 3 } }
    )
  rescue
    raise "unprocessable_entity"
  end
end

# p create_user_comment

def create_contact_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1/comments.json'
  ).to_s
  begin
    puts RestClient.post(
      url,
      { comment: { commentable_id: 1, author_id: 1 } }
    )
  rescue
    raise "unprocessable_entity"
  end
end

def show_user_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1/comments/1.html'
  ).to_s
  puts RestClient.get(url)
end

p show_user_comment

def update_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/comments/1.json'
  ).to_s
  puts RestClient.patch(url, { comment: { commentname: "ryan|" } })
end

def delete_comment
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/comments/4.json'
  ).to_s
  puts RestClient.delete(url)
end
