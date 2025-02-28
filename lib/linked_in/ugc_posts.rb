module LinkedIn
  # UGC Posts APIs
  #
  # @see https://docs.microsoft.com/en-us/linkedin/marketing/integrations/community-management/shares/ugc-post-api
  #
  # [(contribute here)](https://github.com/mdesjardins/linkedin-v2)
  class UgcPosts < APIResource

    # You can retrieve UGC posts by URNs: ugcPostUrn (urn:li:ugcPost:{id}) or shareUrn (urn:li:share:{id}).
    def get_post(options = {})
      urn = options.delete(:urn)
      path = "/ugcPosts/#{urn}?viewContext=AUTHOR"
      ugc_posts_get(path, false, options)
    end

    def get_posts_batch(options = {})
      urns = options.delete(:urns).join(',')
      path = "/ugcPosts?ids=List(#{urns})"
      ugc_posts_get(path, true, options)
    end

    # You can retrieve all UGC posts for a member or an organization. Use authors=List(person Urn) or
    # authors=List(organization Urn) as the query parameter.
    def posts(options = {})
      urn = options.delete(:urn)
      path = "/ugcPosts?q=authors&authors=List(#{urn})"
      ugc_posts_get(path, true, options)
    end

    private

      def ugc_posts_get(path, restli, options = {})
        options[:headers] ||= {}
        options[:headers]['X-Restli-Protocol-Version'] = '2.0.0' if restli
        options[:api_legacy] = true
        get(path, options)
      end

  end
end
