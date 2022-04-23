# frozen_string_literal: true

# Anagram Coding Dojo
module KataManager
  class Anagram < ApplicationService
    def initialize
      @success = true
    end

    def call
      # Logic Bussines..
      success?
    end
  end
end
