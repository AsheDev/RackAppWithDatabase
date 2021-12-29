require 'json'
require 'sequel'

class Endpoints
  class << self
    # An endpoint without a DB call
    def health_check
      [
        200,
        {'Content-Type' => 'application/json'},
        [
          {
            "sucess" => true,
            "allocationId" => ENV.fetch("ALLOCATION_ID")
          }.to_json
        ]
      ]
    end

    def root
      # Record that a request was made against this allocation's endpoint
      requests = @@db[:requests]
      requests.insert(allocation: ENV.fetch("ALLOCATION_ID"))

      [
        200,
        {'Content-Type' => 'application/json'},
        [
          {
            "bobRossSays" => @@quotes[Random.rand(0..2)],
            "allocationId" => ENV.fetch("ALLOCATION_ID")
          }.to_json
        ]
      ]
    end

    def show_requests
      data = database[:requests].all
      begin
        [
          200,
          {'Content-Type' => 'application/json'},
          [
            {
              "count" => data.size,
              "data" => data
            }.to_json
          ]
        ]
      rescue StandardError => e
        [
          200,
          {'Content-Type' => 'application/json'},
          [
            {
              "errorMessage" => e.message,
              "errorFullMessage" => e.full_message
            }.to_json
          ]
        ]
      end
    end

    private

    def database
      @database ||=
        Sequel.connect(
          adapter: :postgres,
          user: ENV.fetch("POSTGRES_USER"),
          password: ENV.fetch("POSTGRES_PASSWORD"),
          host: ENV.fetch("POSTGRES_HOST"),
          port: ENV.fetch("POSTGRES_PORT"),
          database: ENV.fetch("POSTGRES_DATABASE")
        )
    end

    def quotes
      @quotes ||=
        [
          "There's nothing wrong with having a tree as a friend.",
          "The secret to doing anything is believing that you can do it. Anything that you believe you can do strong enough, you can do. Anything. As long as you believe.",
          "If what you're doing doesn't make you happy, you're doing the wrong thing."
        ]
    end
  end
end
