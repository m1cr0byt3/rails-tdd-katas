# frozen_string_literal: true

# Anagram Coding Dojo
module KataManager
  class Anagram < ApplicationService
    def initialize(word_base, path_file)
      config_word(word_base)
      @path_file = path_file
    end
    attr_accessor :word_base, :regex, :list_words, :file_manager, :rest_match

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
      @regex = sort_word(word_base)
    end

    def sort_word(word_base)
      criteria_match(word_base.chars.sort(&:casecmp).join.downcase)
    end

    def criteria_match(word_base_sort)
      word_base_sort.gsub(/(?<word>[a-z])/, '\k<word>?')
    end

    def process_words
      @file_manager = FileManager::Read.call(@path_file)
      evaluate_words
    end

    def evaluate_words
      @list_words = read_file&.gsub(/.*;/, '')&.split&.uniq
      @list_words || []
      raise(StandardError, 'No se encontró ninguna palabra') if @list_words.empty?

      @data[:total_list_words] = @list_words.size
      @list_words.each_with_index { |word, index| part_of_word(word, index) }
    end

    def part_of_word(word, index)
      word = order_word(word)

      match = word.match(/#{@regex}/).to_a.first
      if match.present? && match == word
        @rest_match = criteria_match(remaining_word(match))

        @next_index = index + 1
        match_next(match) while @next_index < @data[:total_list_words]
      else
        false
      end
      true
    end

    def match_next(match)
      rest_chars_total = @word_base.size - match.size
      find_next_match(match) if @list_words[@next_index].size == rest_chars_total
      @next_index += 1
    end

    def find_next_match(match)
      order_next = order_word(@list_words[@next_index])
      next_match = order_next.match(/#{@rest_match}/).to_a.first
      save_matchs(next_match, match) if next_match.present? && remaining_word(match) == order_next
    end

    def save_matchs(next_match, match)
      @data[:matches] << { first: match, second: next_match }
      @success = true
    end

    def remaining_word(match)
      word_format = order_word(@word_base)
      match.chars.each { |char| word_format.sub!(char, '') }
      word_format
    end

    def order_word(word)
      word.chars.sort(&:casecmp).join.downcase
    end

    def read_file
      raise(StandardError, @file_manager.messages) unless @file_manager.success?

      @file_manager.data
    end
  end
end
