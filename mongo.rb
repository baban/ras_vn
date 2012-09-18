require 'mongo'
require 'active_support/all'

module Oklytics
  module Mongo
    extend ActiveSupport::Concern

    included do
      cattr_accessor :collection
    end

    class << self
      def connection=(server)
        case server
        when String
          # TODO file(yaml) load
        when Hash
          @mongo = ::Mongo::Connection.new(server[:host], server[:port], :pool_size => 5, :pool_timeout => 5).db(server[:db])
        when ::Mongo::Connection
          # TODO no test
          @mongo = server
        end
      end

      def connection
        return @mongo if @mongo
        self.connection = ::Mongo::Connection.new("localhost", 27017).db("oklytics")
        self.connection
      end
    end

    module ClassMethods
      def store_collection(collection_name)
        self.collection = collection_name
      end

      def map_reduce(map, reduce, options = {})
        collection_name = options.delete(:collection) || collection
        if options[:out].present? && options[:out][:inline] == true
          Mongo.connection.collection(collection_name).map_reduce(map, reduce, :out => {:inline => true}, :raw => true)["results"]
        else
          Mongo.connection.collection(collection_name).map_reduce(map, reduce, options)
        end
      end
    end
  end
end
