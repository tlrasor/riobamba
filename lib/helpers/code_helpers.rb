require 'sinatra/base'
require 'radix/base'

module Sinatra
  module Riobamba
    module CodeHelpers

      ALPHABET = ["E", "J", "A", "q", "x", "k", "C", "H", "P", "W", "0", "O", "d", "p", "e", "D", "u", "c", "M", "Z", "-", "v", "N", "G", "r", "Q", "l", "B", "j", "2", "y", "t", "S", "3", "9", "1", "b", "Y", "4", "w", "g", "z", "h", "n", "T", "7", "X", "K", "6", "8", "i", "5", "s", "I", "U", "m", "o", "L", "V", "a", "f", "R", "F"]
      BASE_RIO = Radix::Base.new(ALPHABET)

      def toCode(id)
        BASE_RIO.encode(id.to_s)
      end

      def toId(code)
        BASE_RIO.decode(code).to_i
      end

      # def toCode(id)
      #   id.to_s(36)
      # end

      # def toId(code)
      #   code.to_i(36)
      # end
    end
  end
end
