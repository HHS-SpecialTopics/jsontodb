require 'net/http'

module JSONtoDB
  # This module handles REST requests
  module REST
    module_function

    def get(url, user, pass)
      no_data_request(Net::HTTP::Get, url, user, pass)
    end

    def delete(url, user, pass)
      no_data_request(Net::HTTP::Delete, url, user, pass)
    end

    def no_data_request(klass, url, user, pass)
      request = basic_request(klass, url, user, pass)

      make_request(url, request)
    end

    def put(url, src, user, pass)
      data_request(Net::HTTP::Put, url, src, user, pass)
    end

    def post(url, src, user, pass)
      data_request(Net::HTTP::Post, url, src, user, pass)
    end

    def data_request(klass, url, src, user, pass)
      if File.directory?(src)

        Dir["#{src}/*.json"].each do |_file|
          file_request(klass, url, src, user, pass)
        end

      elsif File.file?(src)
        file_request(klass, url, src, user, pass)
      end
    end

    def file_request(klass, url, src, user, pass)
      request = basic_request(klass, url, user, pass)
      request.content_type = 'application/json'
      request.set_form_data(JSONtoDB::IO.read(src))

      make_request(url, request)
    end

    def basic_request(klass, url, user, pass)
      uri = URI(url)
      request = klass.new(uri)
      request.basic_auth(user, pass)
      request
    end

    def make_request(url, request)
      uri = URI(url)

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
