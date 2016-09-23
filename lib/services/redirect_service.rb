require 'services/code_service'
require 'models/redirect'

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