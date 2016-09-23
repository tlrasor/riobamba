require 'sinatra/base'
require "sinatra/namespace"
require "sinatra/multi_route"
require 'logger'

require 'controllers/base_controller'
require 'helpers/json_helpers'
require 'services/code_service'

module Riobamba
  module Controllers
    class RedirectsApiController < BaseController

      log = Logging.logger[self]
      
      configure do
        helpers JsonHelpers
        register Sinatra::Namespace
        register Sinatra::MultiRoute
      end

      def get_url
        if params[:url]
          return params[:url]
        end
        if params[:body]
          json = from_json params[:body]
          params.merge! json
          return get_url
        end
        raise "Unable to decode params #{params}"
      end

      get '/' do
        begin
          @log.debug { params.inspect }
          results = Models::Redirect.all
          coded = results.collect { |r|  {:redirect => r, :code => Services::CodeService.toCode(r.id)}}
          to_json coded
        rescue Exception => msg
          log.error msg
          status 500
          halt to_json({ :status => 'failed', :reason => 'Unable to query for redirects at this time'})
        end
      end

      post '/' do
        begin
          @log.debug { params.inspect }
          url = get_url
          if url == nil
            status 501
            halt to_json({ :status => 'failed', :reason => 'no url specified in body'})
          end
          r = Models::Redirect.first_or_create(:url => url)
          status 201
          to_json({:redirect => r, :code => Services::CodeService.toCode(r.id)})
        rescue Exception => msg
          @log.error "Encountered error in processing request: #{msg}"
          status 500
          halt to_json({ :status => 'failed', :reason => 'Unable to save redirect at this time'})
        end
      end

      get ':id' do |id|
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