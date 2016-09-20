require_relative '../helpers/spec_helper'

require_relative "../../lib/services/code_service"

module Riobamba
  module Services

    describe CodeService do

      before do
        @logger = Logging.logger[self]
      end

      describe "#toCode" do
        it "creates a deterministic string radix code" do
          code = CodeService.toCode(1)
          code.must_equal('8')

          code = CodeService.toCode(99)
          code.must_equal('qn3')
        end
      end

      describe "#toId" do
        it "creates a deterministic integer id from a string radix code" do
          id = CodeService.toId('8')
          id.must_equal(1)

          id = CodeService.toId('qn3')
          id.must_equal(99)
        end
      end
    end

  end
end