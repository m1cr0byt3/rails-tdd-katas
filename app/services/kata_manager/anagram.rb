# frozen_string_literal: true

# Anagram Coding Dojo
module KataManager
  class Anagram < ApplicationService
    def initialize(word_base, path_file)
      config_word(word_base)
      @path_file = path_file
    end
    attr_accessor :word_base, :list_words, :file_manager, :chars_repeated

    def call
      super
      begin
        process_words
      rescue StandardError => error
        fail_process(error.message)
      end
      success?
    end

    private

    def config_word(word_base)
      @word_base = word_base
      @chars_repeated = find_char_repeated!(@word_base)
    end

    def repeated?
      @chars_repeated.size.positive?
    end

    def find_char_repeated!(word)
      chars = word.chars
      chars.select { |char| chars.count(char) > 1 }
           .sort!
    end

    def process_words
      @file_manager = FileManager::Read.call(@path_file)
      @list_words = clean_words
    end

    def clean_words
      matches = evaluate_words
      binding.pry
    end

    def evaluate_words
      words = read_file&.gsub(/.*;/, '')&.split&.uniq
      words || []
      raise(StandardError, 'No se encontró ninguna palabra') if words.empty?

      words.select { |word| part_of_word?(word) }
    end

    def part_of_word?(word)
      return false if filter_repeat?(word)

      coincidences = word.chars.grep(/[#{word_base}]/)
      coincidences.size == word.size
    end

    def filter_repeat?(word)
      return false unless repeated?

      current_word_repeated = find_char_repeated!(word)
      return current_word_repeated != @chars_repeated if current_word_repeated.size.positive?

      false
    end

    def read_file
      raise(StandardError, @file_manager.messages) unless @file_manager.success?

      @file_manager.data
    end
  end
end
