require 'sinatra/base'
require 'oj'
require 'multi_json'
module Sinatra
  module Riobamba
    module JsonHelpers

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

      def from_json obj
        MultiJson.load(obj, :symbolize_keys => true)
      end

      def to_json obj
        MultiJson.dump(obj)
      end
    end
  end
end