require 'byebug'

class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method, @controller_class, @action_name =
      [pattern, http_method, controller_class, action_name]
  end

  # checks if pattern matches path and method matches request method
  def matches?(req)
    match = @pattern.match(req.path)
    if match
      return (match[0] == req.path &&
              @http_method == req.request_method.downcase.to_sym)
    else
      return false
    end
  end

  # use pattern to pull out route params (save for later?)
  # instantiate controller and call controller action
  def run(req, res)
    match_data = @pattern.match(req.path)
    route_params = {}
    match_data.names.each_with_index do |name, idx|
      route_params[name.to_sym] = match_data.captures[idx]
    end

    controller = controller_class.new(req, res, route_params)
    controller.invoke_action(@action_name)
  end
end

class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  # simply adds a new route to the list of routes
  def add_route(pattern, method, controller_class, action_name)
    self.routes << Route.new(pattern, method, controller_class, action_name)
  end

  # evaluate the proc in the context of the instance
  # for syntactic sugar :)
  def draw(&proc)
    instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, method=http_method, controller_class, action_name|
      add_route(pattern, method, controller_class, action_name)
    end
  end

  # should return the route that matches this request
  def match(req)
    routes.find { |route| route.pattern.match(req.path) }
  end

  # either throw 404 or call run on a matched route
  def run(req, res)
    matched = match(req)
    if matched
      matched.run(req, res)
    else
      res.status = 404
    end
  end
end
