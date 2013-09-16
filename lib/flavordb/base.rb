module Flavordb
  class Base
    attr_reader :id, :name, :resource

    class << self
      def get_or_create (data)
        #puts "GET OR CREATE #{data}"
        object_id = data['id']
        #puts "OBJECT ID #{object_id}"
        if object_id.nil?
          nil
        else
          object = object_cache[object_id]
          if object.nil?
            object = self.new data
            object_cache[object_id] = object
          end
          object
        end
      end
    end


    protected
    def initialize (data)
      @id = data['id']
      @name = data['name']
      @resource = data['resource']
      @description = data['description']
    end

  end
end