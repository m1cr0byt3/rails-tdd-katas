# frozen_string_literal: true

module CustomExceptions
  class ParserInvalid < StandardError
    def initialize
      super(I18n.t('exceptions.parser_invalid'))
    end
  end
end
