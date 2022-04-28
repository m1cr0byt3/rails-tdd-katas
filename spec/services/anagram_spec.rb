# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(KataManager::Anagram, type: :service) do
  describe '#call' do
    let(:anagram) { KataManager::Anagram.call(Utils::WORD, Files::OK) }
    let(:anagram_failed) { KataManager::Anagram.call(Utils::WORD, Files::ORIGINAL) }

    context 'when success' do
      it 'validate words' do
        expect(anagram.success?).to be(true)
      end
      it 'total words in file' do
        expect(anagram.data[:total_list_words]).to be(Utils::EVAL_WORDS)
      end
    end

    context 'when fail' do
      it 'validate words' do
        expect(anagram_failed.success?).to be(false)
      end
    end
  end
end
