# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(KataManager::Anagram, type: :service) do
  describe '#call' do
    it 'should return success?' do
      response_anagram = KataManager::Anagram.call
      expect(response_anagram.success?).to be(true)
    end
  end
end
