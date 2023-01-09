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
      get(path, options)
    end

    def industries(options = {})
      path = "/industries"
      get(path, options)
    end

    def countries(options = {})
      path = "/countries"
      get(path, options)
    end

    def seniorities(options = {})
      path = "/seniorities"
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
      data_get(path, options)
    end

    private

      # Add X-Restli header
      def data_get(path, options = {})
        options[:headers] ||= {}
        options[:headers]['X-Restli-Protocol-Version'] = '2.0.0'
        get(path, options)
      end

  end

end
