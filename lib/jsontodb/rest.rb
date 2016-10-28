require 'net/http'

module JSONtoDB
  # This module handles
  # REST requests
  module REST
    module_function

    def get(url, user, pass)
      uri = URI(url)
      request = Net::HTTP::Get.new(uri)
      request.basic_auth(user, pass)

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end

      handle_errors(response)
    end

    def delete(url, user, pass)
      uri = URI(url)
      request = Net::HTTP::Delete.new(uri)
      request.basic_auth(user, pass)

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end

      handle_errors(response)
    end

    def put(url, user, pass)
      uri = URI(url)
      request = Net::HTTP::Put.new(uri)
      request.basic_auth(user, pass)
      request.content_type = 'application/json'
      request.set_form_data('title' => 'Test Title', 'content' => 'This is a test post.')

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end

      handle_errors(response)
    end

    def post(url, user, pass)
      uri = URI(url)
      request = Net::HTTP::Post.new(uri)
      request.basic_auth(user, pass)
      request.content_type = 'application/json'
      request.set_form_data('status' => 'publish', 'title' => 'Test Title', 'content' => 'This is a test post.')

      response = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(request)
      end

      handle_errors(response)
    end

    def handle_errors(response)
      return response.body if response.code.start_with?('20')

      puts "ERROR: '#{response.code}' response. (#{response.message} - #{response.class.name})"
      ''
    end
  end
end
