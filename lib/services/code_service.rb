require 'radix/base'

module Riobamba
  module Services
    class CodeService

      def self.toCode(id)
        CodeService.getBase().encode(id.to_s)
      end

      def self.toId(code)
        CodeService.getBase().decode(code).to_i
      end

      protected

      def self.getBase()
        alpha = ["E", "J", "A", "q", "x", "k", "C", "H", "P", "W", "0", "O", "d", "p", "e", "D", "u", "c", "M", "Z", "-", "v", "N", "G", "r", "Q", "l", "B", "j", "2", "y", "t", "S", "3", "9", "1", "b", "Y", "4", "w", "g", "z", "h", "n", "T", "7", "X", "K", "6", "8", "i", "5", "s", "I", "U", "m", "o", "L", "V", "a", "f", "R", "F"]
        base = Radix::Base.new(alpha)
        return base
      end
    end
  end
end