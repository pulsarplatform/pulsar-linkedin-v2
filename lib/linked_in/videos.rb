module LinkedIn
  # Videos APIs
  #
  # See APIResource class for @options params
  #
  # Docs: https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/videos-api

  class Videos < APIResource

    # You can retrieve Posts by Video URN (urn:li:video:{id})
    def get_video(options = {})
      urn = options.delete(:urn)
      path = "/videos/#{urn}"
      videos_get(path, options)
    end

    # Multiple images can be retrieved and viewed in a single API call by passing in multiple Video URN into the ids parameter
    def get_videos_batch(options = {})
      urns = options.delete(:urns).join(',')
      path = "/videos?ids=List(#{urns})"
      videos_get(path, options)
    end

    private

      def videos_get(path, options = {})
        options[:headers] ||= {}
        get(path, options)
      end

  end
end