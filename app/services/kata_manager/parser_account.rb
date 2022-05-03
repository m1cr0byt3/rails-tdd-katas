# frozen_string_literal: true

# Parser Scan Account Bank Coding Dojo
module KataManager
  class ParserAccount < ApplicationService
    DIGITS_INDEX = [' _ | ||_|', '     |  |', ' _  _||_ '].freeze
    private_constant :DIGITS_INDEX
    COINCIDENCE_SEGMENT = 3
    private_constant :COINCIDENCE_SEGMENT
    MAXIM_SIZE = 27
    private_constant :MAXIM_SIZE
    def initialize(path_file)
      init_file(path_file)
    end
    attr_accessor :content_file, :lines

    def call
      super
      begin
        read_numbers
      rescue StandardError => error
        fail_process(error.message)
      end
      success?
    end

    private

    def read_numbers
      clean_lines
      @data[:account_numbers] = parsing_lines.compact!
      @success = true
    end

    def parsing_lines
      @lines.map.with_index do |line, index|
        next if (index % COINCIDENCE_SEGMENT).nonzero?

        raise(CustomExceptions::ParserInvalid) if line.size > MAXIM_SIZE

        read_per_line(line, index).join
      end
    end

    def read_per_line(line, index)
      line.scan(/.{1,3}/).map.with_index do |segment_line, index_line|
        build_digit_number(segment_line, index_line, index)
      end
    end

    def build_digit_number(segment_line, index_line, index)
      next_segment = index_line * COINCIDENCE_SEGMENT
      complete_line = segment_line + next_line(next_segment, index + 1) + next_line(next_segment, index + 2)
      DIGITS_INDEX.index(complete_line)
    end

    def next_line(next_segment, next_index)
      @lines[next_index][next_segment..(next_segment + COINCIDENCE_SEGMENT - 1)]
    end

    def clean_lines
      @lines = remove_lines.select.with_index { |_, index| ((index + 1) % COINCIDENCE_SEGMENT) + 1 != 0 }
    end

    def remove_lines
      read_file.lines.map { |line| line.delete!("\n") }
    end
  end
end
