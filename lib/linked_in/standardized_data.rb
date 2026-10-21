module LinkedIn
  # Ad Analytics API
  #
  # @see https://docs.microsoft.com/en-us/linkedin/shared/references/v2/standardized-data
  #
  # [(contribute here)](https://github.com/mdesjardins/linkedin-v2)
  class StandardizedData < APIResource

    def degrees(options = {})
      path = "/degrees"
      get(path, options)
    end

    def fields_of_study(options = {})
      path = "/fieldsOfStudy"
      get(path, options)
    end

    def functions(options = {})
      path = "/functions"
      # Workaround to use old api_legacy for this endpoint.
      # Since v202308 the Versioned API doesn't give more access to Functions endpoint (TO DO: check next updates and API permission changes)
      options[:api_legacy] = true
      get(path, options)
    end

    def industries(options = {})
      path = "/industries"
      # Workaround to use old api_legacy for this endpoint.
      # Since v202308 the Versioned API doesn't return URN id in Industries endpoint (TO DO: check next updates and API permission changes)
      options[:api_legacy] = true
      get(path, options)
    end

    # Industry Taxonomy Versions (V2). Use this to resolve industry URNs returned by
    # organization follower/page statistics.
    # Omit locale query params: with Rest.li 2.0, locale.language/locale.country are
    # rejected (403 Unpermitted fields). LinkedIn defaults to en_US when omitted.
    # @see https://learn.microsoft.com/en-us/linkedin/shared/references/v2/standardized-data/industrytaxonomyversions
    # @option ids [Array] industry numeric ids
    # @option version [String] taxonomy version (DEFAULT = latest)
    def industry_taxonomy(options = {})
      version = options.delete(:version) || 'DEFAULT'
      ids = Array(options.delete(:ids)).map(&:to_s)
      path = if ids.any?
               "/industryTaxonomyVersions/#{version}/industries?ids=List(#{ids.join(',')})"
             else
               "/industryTaxonomyVersions/#{version}/industries"
             end
      options[:api_legacy] = true
      restli_get(path, options)
    end

    def countries(options = {})
      path = "/countries"
      get(path, options)
    end

    def seniorities(options = {})
      path = "/seniorities"
      # Workaround to use old api_legacy for this endpoint.
      # Since v202308 the Versioned API doesn't return URN id in Seniorities endpoint (TO DO: check next updates and API permission changes)
      options[:api_legacy] = true
      get(path, options)
    end

    def skills_data(options = {})
      path = "/skills?locale.language=en&locale.country=US"
      get(path, options)
    end

    def super_titles(options = {})
      path = "/superTitles"
      get(path, options)
    end

    def titles(options = {})
      path = "/titles"
      get(path, options)
    end

    def iab_categories(options = {})
      path = "/iabCategories"
      get(path, options)
    end

    def geo(options = {})
      urns = options.delete(:urns).join(',')
      path = "/geo?ids=List(#{urns})"
      options[:api_legacy] = true
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
