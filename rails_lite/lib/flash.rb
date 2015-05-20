require 'json'
require 'webrick'
require 'byebug'

class Flash
  attr_reader :flash, :cookie

  def initialize(req)
    @cookie = req.cookies.find { |c| c.name == '_rails_lite_app' }
    @flash = cookie ? JSON.parse(cookie.value) : {}
  end

  def [](key)
    @flash[key]
  end

  def []=(key, value)
    @flash[key] = value
  end

  def now
    
  end

  def store_flash(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', JSON.dump(@flash))
  end
end
