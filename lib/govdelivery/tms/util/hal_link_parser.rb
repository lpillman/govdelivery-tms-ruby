module GovDelivery::TMS::Util
  module HalLinkParser

    def parse_links(_links)
      @resources = {}
      return if _links.nil?
      parse_link(_links) and return if _links.is_a?(Hash)
      _links.each { |link| parse_link(link) }
    end

    def subresources
      @resources
    end

    protected

    def metaclass
      @metaclass ||= class << self;
        self;
      end
    end

    def parse_link(link)
      link.each do |rel, href|
        if rel == 'self'
          self.href = href
        else
          klass = relation_class(rel)
          klass = self.class if ['first', 'prev', 'next', 'last'].include?(rel)
          if klass
            subresources[rel] = klass.new(self.client, href)
            setup_subresource(link)
          else
            logger.info("Don't know what to do with link rel '#{rel}' for class #{self.class.to_s}!") if self.respond_to?(:logger)
          end

        end
      end
    end

    def relation_class(rel)
      ::GovDelivery::TMS.const_get(classify(rel)) rescue nil
    end

    def setup_subresource(link)
      return unless link
      link.each { |rel, href| self.metaclass.send(:define_method, rel.to_sym, &lambda { subresources[rel] }) unless rel == 'self' }
    end
  end
end