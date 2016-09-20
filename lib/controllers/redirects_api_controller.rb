require 'sinatra/base'
require_relative 'base_controller'

module Riobamba
  module Controllers
    class RedirectsApiController < BaseController


      get '/api/r' do
        begin
          @log.debug { params.inspect }
          results = Models::Redirect.all
          coded = results.collect { |r|  {:redirect => r, :code => toCode(r.id)}}
          to_json coded
        rescue
          "[]"
        end
      end

      post '/api/r' do
        begin
          @log.debug { params.inspect }
          url = get_url
          if url == nil
            status 500
            halt to_json({ :status => 'failed', :reason => 'no url specified in body'})
          end
          r = Models::Redirect.first_or_create(:url => url)
          if not r.saved?
            raise 'Unable to save request'
          end
          status 201
          to_json({:redirect => r, :code => toCode(r.id)})
        rescue Exception => msg
          @log.error "Encountered error in processing request: #{msg}"
          status 500
          halt to_json({ :status => 'failed'})
        end
      end

      get '/api/r/:id' do |id|
        begin
          r = Models::Redirect.get(id)
          if r.nil?
            raise "Unable to find id #{id}"
          end
          to_json r
        rescue Exception => msg
          @log.error "Encountered error in processing request: #{msg}"
          not_found
        end
      end

      # put '/api/r/:id' do |id|
      #   @log.debug { params.inspect }
      #   r = Models::Redirect.get(id)
      #   if r.nil?
      #     not_found
      #   end
      #   halt 500 unless r.update(:url => get_url)
      #   status 201
      #   to_json({:redirect => r, :code => toCode(r.id)})
      # end

      # delete '/api/r/:id' do |id|
      #   r = Models::Redirect.get(id)
      #   if r.nil?
      #     not_found
      #   end
      #   halt 500 unless r.destroy
      #   to_json({ :status => "success" })
      # end
    end
  end
end