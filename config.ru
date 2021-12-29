require_relative 'router'
require_relative 'endpoints'

# We want the root route at the very end, otherwise other routes won't be
# matched properly by the Router
run Router.new([
  {
    :path => %r{^/db},
    :method => "GET",
    :route => Endpoints.show_requests
  },
  {
    :path => %r{^/health_check},
    :method => "GET",
    :route => Endpoints.health_check
  },
  {
    :path => %r{^/},
    :method => "GET",
    :route => Endpoints.root
  }
]);
