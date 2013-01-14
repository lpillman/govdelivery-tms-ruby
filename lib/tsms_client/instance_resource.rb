module TSMS::InstanceResource
  def self.included(base)
    base.send(:include, TSMS::Base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module ClassMethods
    #
    # Writeable attributes are sent on POST/PUT.
    #
    def writeable_attributes(*attrs)
      @writeable_attributes ||= []
      if attrs.any?
        @writeable_attributes.map!(&:to_sym).concat(attrs).uniq! if attrs.any?
        setup_attributes(@writeable_attributes, false)
      end
      @writeable_attributes
    end

    #
    # Readonly attributes don't get POSTed.
    # (timestamps are included by default)
    #
    def readonly_attributes(*attrs)
      @readonly_attributes ||= [:created_at, :updated_at, :completed_at]
      if attrs.any?
        @readonly_attributes.map!(&:to_sym).concat(attrs).uniq!
        setup_attributes(@readonly_attributes, true)
      end
      @readonly_attributes
    end

    #
    # For collections that are represented as attributes (i.e. inline, no href)
    #
    # # message.rb
    # collection_attributes :recipients
    def collection_attributes(*attrs)
      @collection_attributes ||= []
      if attrs.any?
        @collection_attributes.map!(&:to_sym).concat(attrs).uniq! if attrs.any?
        @collection_attributes.each { |a| setup_collection(a) }
      end
      @collection_attributes
    end

    def custom_class_names
      @custom_class_names ||= {}
    end

    #
    # For collections that are represented as attributes (i.e. inline, no href)
    # and that have a class name other than the one we would infer.
    #
    # # email.rb
    # collection_attributes :recipients, 'EmailRecipient'
    def collection_attribute(attr, tms_class)
      @collection_attributes ||= []
      @collection_attributes.push(attr).uniq!
      setup_collection(attr, TSMS.const_get(tms_class))
    end

    def setup_attributes(attrs, readonly=false)
      attrs.map(&:to_sym).each do |property|
        self.send :define_method, :"#{property}=", &lambda { |v| @attributes[property] = v } unless readonly
        self.send :define_method, property.to_sym, &lambda { @attributes[property] }
      end
    end

    def setup_collection(property, klass=nil)
      if klass
        custom_class_names[property] = klass
      else
        klass ||= TSMS.const_get(property.to_s.capitalize)
      end

      self.send :define_method, property.to_sym, &lambda { @attributes[property] ||= klass.new(self.client, nil, nil) }
    end
  end

  module InstanceMethods
    def initialize(client, href=nil, attrs=nil)
      super(client, href)
      @attributes = {}
      attrs ||= self.client.get(href).body if href
      set_attributes_from_hash(attrs) if attrs
    end

    def get
      set_attributes_from_hash(self.client.get(href).body)
      self
    end

    def post
      response = client.post(self)
      case response.status
        when 201
          set_attributes_from_hash(response.body)
          return true
        when 401
          raise Exception.new("401 Not Authorized")
        when 404
          raise(Exception.new("Can't POST to #{self.href}"))
        else
          if response.body['errors']
            self.errors = response.body['errors']
          end
      end
      return false
    end

    def put
      response = client.put(self)
      case response.status
        when 200
          set_attributes_from_hash(response.body)
          return true
        when 401
          raise Exception.new("401 Not Authorized")
        when 404
          raise(Exception.new("Can't POST to #{self.href}"))
        else
          if response.body['errors']
            self.errors = response.body['errors']
          end
      end
      return false
    end

    def delete
      response = self.client.delete(href)
      case response.status
        when 200
          return true
        else
          if response.body['errors']
            self.errors = response.body['errors']
          end
      end
      return false
    end

    def to_s
      "<#{self.class.inspect}#{' href=' + self.href if self.href} attributes=#{@attributes.inspect}>"
    end

    def to_json
      json_hash = {}
      self.class.writeable_attributes.each do |attr|
        json_hash[attr] = self.send(attr)
      end
      self.class.collection_attributes.each do |coll|
        json_hash[coll] = self.send(coll).to_json
      end
      json_hash
    end

    private

    def set_attributes_from_hash(hash)
      hash.reject { |k, _| k=~/^_/ }.each do |property, value|
        if self.class.collection_attributes.include?(property.to_sym)
          klass = self.class.custom_class_names[property] || TSMS.const_get(property.to_s.capitalize)
          @attributes[property.to_sym] = klass.new(client, nil, value)
        else
          @attributes[property.to_sym] = value
        end
      end
      self.errors = hash['errors']
      parse_links(hash['_links'])
    end

  end
end