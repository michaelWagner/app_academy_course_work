require 'json'
require 'webrick'
require 'byebug'

class Flash
  attr_reader :flash, :cookie

  def initialize(req)
    @cookie = req.cookies.find { |c| c.name == '_rails_lite_app' }
    @old_flash = cookie ? JSON.parse(cookie.value) : {}

    @old_flash ||= {}
    @new_flash = {}
  end

  def [](key)
    @flash_now ? @old_flash[key] : @old_flash[key.to_s]
  end

  def []=(key, value)
    @new_flash[key] = value
  end

  def now
    @flash_now = true
    @old_flash
  end

  def store_flash(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', JSON.dump(@new_flash))
  end
end
