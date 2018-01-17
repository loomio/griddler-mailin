module Griddler
  module Mailin
    class Adapter
      def initialize(params)
        if params['mailinMsg'].is_a? String
          @params = JSON.parse(params['mailinMsg'])
        else
          @params = params['mailinMsg']
        end
      end

      def self.normalize_params(params)
        adapter = new(params)
        adapter.normalize_params
      end

      def normalize_params
        {
          to: parse_recipients(params['to']),
          cc: parse_recipients(params['cc']),
          from: parse_recipients(params['from']).first,
          subject: params['subject'],
          text: params['text'],
          html: params['html'],
        }
      end

      private

      attr_reader :params

      def parse_recipients(lines)
        Array(lines).map do | obj |
          "#{obj['name']} <#{obj['address']}>"
        end
      end
    end
  end
end
