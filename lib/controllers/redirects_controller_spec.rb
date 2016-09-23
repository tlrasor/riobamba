require 'helpers/spec_helper'

require 'controllers/redirects_controller'
require 'services/code_service'

module Riobamba
  module Controllers
    describe RedirectsController do

      def app
        Rack::Builder.parse_file('config.ru').first
      end

      before do
        @log = Logging.logger[self]
        url = "http://something.org/something?=12asd"
        @r = Models::Redirect.create(:url => url)
        @code = Services::CodeService.toCode(@r.id)
      end

      describe "gets pages" do
        it "returns a page for a code" do
          get '/r/'+@code
          assert last_response.ok?
          assert last_response.length >=1
        end
      end

    end
  end
end