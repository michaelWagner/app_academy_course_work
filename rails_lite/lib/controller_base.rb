require 'active_support'
require 'active_support/core_ext'
require 'erb'
require 'active_support/inflector'
require_relative './session'
require_relative './flash'
require_relative './params'


class ControllerBase
  attr_reader :req, :res
  attr_reader :params, :session, :flash
  attr_accessor :already_built_response

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
    @params = Params.new(req, route_params)
    @session = session
    @flash = flash
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
  end

  # Set the response status code and header
  def redirect_to(url)
    if @already_built_response
      raise
    else
      self.res.header['location'] = url.to_s
      self.res.status = 302
      @already_built_response = true
      @session.store_session(@res)
      @flash.store_flash(@res)
    end
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    if @already_built_response
      raise
    else
      @already_built_response = true
      @res.content_type = content_type
      @res.body = content
      @session.store_session(@res)
      @flash.store_flash(@res)
    end
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    binding
    file_name = "views/#{self.class.to_s.underscore}/#{template_name.to_s}.html.erb"
    content = ERB.new(File.read(file_name)).result(binding)
    render_content(content, "text/html")
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(@req)
  end

  def flash
    @flash ||= Flash.new(@req)
  end
end
