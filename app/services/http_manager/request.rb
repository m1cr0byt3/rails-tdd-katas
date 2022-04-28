# frozen_string_literal: true

# Service to Http requests
module HttpManager
  class Request < ApplicationService
    include HTTParty
    def initialize(url, base_uri = '')
      @url = "#{base_uri}#{url}"
      @options = options
    end

    attr_accessor :url, :options, :response, :body

    def get(options = {})
      @response = self.class.get(@url, options)
      @body = @response.body
      @response.ok?
    end
  end
end
