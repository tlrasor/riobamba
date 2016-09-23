require 'sinatra/base'
require 'oj'
require 'multi_json'

module Riobamba
  module JsonHelpers

    def from_json obj
      MultiJson.load(obj, :symbolize_keys => true)
    end

    def to_json obj
      MultiJson.dump(obj)
    end
  end
end