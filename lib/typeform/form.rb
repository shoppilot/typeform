require 'typeform'
require 'json'

module Typeform

  class Form
    attr_reader :form_id

    def initialize(form_id)
      @form_id = form_id
    end

    def all_entries
      entries
    end

    def complete_entries(params = {})
      entries(params.merge(completed: true))
    end

    def incomplete_entries(params = {})
      entries(params.merge(completed: false))
    end

    def entries(params = nil)
      params ||= {}
      params[:key] = Typeform.api_key
      response = Typeform.get(uri, query: params)
      Hashie::Mash.new(response)
    end

    private
      def uri
        "/form/#{form_id}"
      end
  end

end
