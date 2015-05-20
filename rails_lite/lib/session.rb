require 'json'
require 'webrick'
require 'byebug'

class Session
  attr_reader :cookie
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    @cookie = req.cookies.find { |c| c.name == '_rails_lite_app' }
    @session = cookie ? JSON.parse(cookie.value) : {}
  end

  def [](key)
    @session[key]
  end

  def []=(key, val)
    @session[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', JSON.dump(@session))
  end
end
