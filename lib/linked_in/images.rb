module LinkedIn
  # Images APIs
  #
  # See APIResource class for @options params
  #
  # Docs: https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/images-api

  class Images < APIResource

    # You can retrieve Posts by Image URN (urn:li:image:{id})
    def get_image(options = {})
      urn = options.delete(:urn)
      path = "/images/#{urn}"
      get(path, options)
    end

    # Multiple images can be retrieved and viewed in a single API call by passing in multiple Image URN into the ids parameter
    def get_images_batch(options = {})
      urns = options.delete(:urns).join(',')
      path = "/images?ids=List(#{urns})"
      restli_get(path, options)
    end

    private

      # Add X-Restli header
      def restli_get(path, options = {})
        options[:headers] ||= {}
        options[:headers]['X-Restli-Protocol-Version'] = '2.0.0'
        get(path, options)
      end

  end
end