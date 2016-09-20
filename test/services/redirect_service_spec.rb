require_relative '../helpers/spec_helper'

require_relative "../../lib/services/redirect_service"
require_relative "../../lib/services/code_service"


module Riobamba
  module Services
    describe RedirectService do

      before do
        @logger = Logging.logger[self]

        @test_url = "http://example.com/something?=12asd"
        @test_model = Models::Redirect.create(:url => @test_url)
        @code = CodeService.toCode(@test_model.id)
      end

      describe "#getByCode" do
        describe "Creates a view model" do
          it "creates a view model" do
            view_model = RedirectService.getByCode(@code)
            
            view_model.wont_be_nil
            view_model.url.must_equal(@test_url)

          end
        end
      end
    end
  end
end