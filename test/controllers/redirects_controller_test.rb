require_relative '../helpers/controller_helper'

require 'controllers/redirects_controller'
require 'services/code_service'

module Riobamba
  module Tests
    class RedirectsApiControllerTest < TestFixture

      def setup
        @log = Logging.logger[self]
        url = "http://something.org/something?=12asd"
        @r = Models::Redirect.create(:url => url)
        @code = Services::CodeService.toCode(@r.id)
      end

      def test_get
        get '/r/'+@code
        assert last_response.ok?
        assert last_response.length >=1
      end

    end
  end
end