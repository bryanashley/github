# encoding: utf-8

module Github
  class Search < API
    include Github::Utils::Url

    # Search issues
    #
    # Find issues by state and keyword.
    #
    # = Parameters
    #  <tt>:state</tt> - open or closed.
    #  <tt>:keyword</tt> - search term
    #
    # = Examples
    #  github = Github.new
    #  github.search.issues 'owner', 'repo-name', 'open','api'
    #  github.search.issues owner: 'owner', repo: 'repo-name', state: 'open', keyword: 'api'
    #
    def issues(*args)
      required = ['owner', 'repo', 'state', 'keyword']
      arguments(args, :required => required)

      get_request("/legacy/issues/search/#{owner}/#{repo}/#{state}/#{escape_uri(keyword)}", arguments.params)
    end

    # Search repositories
    #
    # Find repositories by keyword.
    #
    # = Parameters
    #  <tt>:keyword</tt> - search term
    #
    # = Examples
    #  github = Github.new
    #  github.search.repos 'api'
    #  github.search.repos keyword: 'api'
    #
    def repos(*args)
      arguments(args, :required => [:keyword])

      get_request("/legacy/repos/search/#{escape_uri(keyword)}", arguments.params)
    end
    alias :repositories :repos

    # Search users
    #
    # Find users by keyword.
    #
    # = Parameters
    #  <tt>:keyword</tt> - search term
    #
    # = Examples
    #  github = Github.new
    #  github.search.users keyword: 'wycats'
    #
    def users(*args)
      arguments(args, :required => [:keyword])

      get_request("/legacy/user/search/#{escape_uri(keyword)}", arguments.params)
    end

    # Search code
    #
    # Find issues by state and keyword.
    #
    # = Parameters
    #  <tt>:state</tt> - open or closed.
    #  <tt>:keyword</tt> - search term
    #
    # = Examples
    #  github = Github.new
    #  github.search.issues 'owner', 'repo-name', 'open','api'
    #  github.search.issues owner: 'owner', repo: 'repo-name', state: 'open', keyword: 'api'
    #
    def issues(*args)
      required = ['owner', 'repo', 'state', 'keyword']
      arguments(args, :required => required)

      get_request("/legacy/issues/search/#{owner}/#{repo}/#{state}/#{escape_uri(keyword)}", arguments.params)
    end
    # Search code
    #
    # @param query [String] Search term and qualifiers
    # @param options [Hash] Sort and pagination options
    # @option options [String] :sort Sort field
    # @option options [String] :direction Sort direction (asc or desc)
    # @option options [Fixnum] :page Page of paginated results
    # @option options [Fixnum] :per_page Number of items per page
    # @return [Sawyer::Resource] Search results object
    # @see http://developer.github.com/v3/search/#search-code
    def search_code(query)
      get_request("/search/code?#{query}")
    end

    # Search email
    #
    # This API call is added for compatibility reasons only. There’s no
    # guarantee that full email searches will always be available.
    #
    # = Parameters
    #  <tt>:keyword</tt> - search term
    #
    # = Examples
    #  github = Github.new
    #  github.search.email email: 'wycats'
    #
    def email(*args)
      arguments(args) do
        assert_required %w[ email ]
      end
      params = arguments.params

      get_request("/legacy/user/email/#{params.delete('email')}", params)
    end

  end # Search
end # Github
