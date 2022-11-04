module LinkedIn
  # Posts APIs
  #
  # See APIResource class for @options params
  # 
  # Docs: https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/posts-api
  # Migration reference: https://learn.microsoft.com/en-us/linkedin/marketing/integrations/community-management/contentapi-migration-guide
  
  class Posts < APIResource

    # You can retrieve Posts by URNs: ugcPostUrn (urn:li:ugcPost:{id}) or shareUrn (urn:li:share:{id}).
    def get_post(options = {})
      urn = options.delete(:urn)
      path = "/posts/#{urn}"
      posts_get(path, options)
    end

    # Multiple posts can be retrieved and viewed in a single API call by passing in multiple ugcPostUrn or shareUrn into the ids parameter. 
    def get_posts_batch(options = {})
      urns = options.delete(:urns).join(',')
      path = "/posts?ids=List(#{urns})"
      posts_get(path, options)
    end

    # You can retrieve all posts for an organization. With isDsc param true, returns posts that are direct sponsored content. If false, returns organic posts.
    def posts(promoted: false, options = {})
      urn = options.delete(:urn)
      path = "/posts?author=#{urn}&q=author"
      path += "&idDsc=true" if promoted
      posts_get(path, options)
    end

    private

      def posts_get(path, options = {})
        options[:headers] ||= {}
        options[:headers]['X-Restli-Protocol-Version'] = '2.0.0'
        get(path, options)
      end

  end
end
