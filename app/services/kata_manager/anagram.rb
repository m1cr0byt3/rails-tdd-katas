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
        binding.pry
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
      puts "word: #{word}"
      match = word.match(/#{@regex}/).to_a.first
      if match.present? && match == word
        @rest_match = remaining_word(match)
        puts "rest_match: #{@rest_match}"
        @next_index = index + 1
        next_word = @list_words[@next_index]
        rest_chars_total = @word_base.size - match.size
        match_next(next_word, match) while @next_index < @data[:total_list_words] && next_word.size == rest_chars_total
      else
        false
      end
      true
    end

    def match_next(next_word, match)
      next_match = next_word.match(/#{@rest_match}/).to_a.first
      puts "match: #{match},next_match #{next_match}  next_word: #{next_word}"
      save_matchs(next_match, match) if next_match.present? && next_match == next_word
      @next_index += 1
    end

    def save_matchs(_next_match, _match)
      puts '123'
    end

    def remaining_word(match)
      binding.pry if match == 'cein'
      remaining = order_word(@word_base).chars.grep(/[^#{match}]/)
      criteria_match(remaining.join)
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
