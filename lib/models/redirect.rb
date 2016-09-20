require 'data_mapper'

module Riobamba
  module Models
    class Redirect

      include DataMapper::Resource

      property :id, Serial
      property :url, String, :required => true, :unique => true, :length => 8..2048, :format => :url
      property :uses, Integer, :default => 0
      property :created_at, DateTime
      property :updated_at, DateTime

      def to_s
        str = "#{self.class}: { 'id': '%s', 'url': '%s', 'created_at': '%s' }" % [id, url, created_at]
        str
      end

    end
  end
end