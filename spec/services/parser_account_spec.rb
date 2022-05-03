# frozen_string_literal: true

require 'rails_helper'
RSpec.describe(KataManager::ParserAccount, type: :service) do
  describe '#call' do
    let(:parser_account) { KataManager::ParserAccount.call(Files::BANK_ACCOUNT) }
    let(:parser_account_fail) { KataManager::ParserAccount.call(Files::BANK_ACCOUNT_TEN) }

    context 'when success' do
      it 'parser number' do
        expect(parser_account.success?).to be(true)
      end
      it 'number 000000000' do
        expect(parser_account.data[:account_numbers].first).to eq('000000000')
      end
    end
    context 'when fail' do
      it 'parser number with ten digits' do
        expect(parser_account_fail.success?).to be(false)
      end
      it 'check messages fail' do
        expect(parser_account_fail.messages).to eq(I18n.t('exceptions.parser_invalid'))
      end
    end
  end
end
