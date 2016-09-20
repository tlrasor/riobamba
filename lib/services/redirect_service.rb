require_relative 'code_service'
require_relative '../models/redirect'

module Riobamba
  module Services
    class RedirectService

      def self.getByCode(code)
        id = CodeService.toId(code)
        r = Models::Redirect.first(:id => id)
        return r
      end

    end
  end
end