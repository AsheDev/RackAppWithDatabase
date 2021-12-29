class Router
  def initialize(routes)
    @routes = routes
  end

  def four_oh_four
    [404, {'Content-Type' => 'application/json'}, ["Not Found!"]]
  end

  def call(env)
    route = routes.detect do |r|
      env['REQUEST_PATH'].match(r[:path]) && env['REQUEST_METHOD'] == r[:method]
    end

    route ? route[:route].call(env, env['REQUEST_PATH']) : four_oh_four
  end

  private
  attr_reader :routes
end
