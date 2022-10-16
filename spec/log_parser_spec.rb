# frozen_string_literal: true

require_relative '../log_parser'

RSpec.describe LogParser do
  let(:parser) { LogParser.new(log_file_path) }
  context 'when there is only one page' do
    let(:log_file_path) { 'spec/fixtures/one_page.log' }

    describe '.pages_by_visits' do
      it 'returns one result' do
        expect(parser.pages_by_visits.size).to eq(1)
      end

      it 'reports three visits' do
        expect(parser.pages_by_visits.first).to eq('/home 3')
      end
    end

    describe '.pages_by_unique_visits' do
      it 'returns one result' do
        expect(parser.pages_by_unique_visits.size).to eq(1)
      end

      it 'reports three visits' do
        expect(parser.pages_by_unique_visits.first).to eq('/home 2')
      end
    end

    describe '.report' do
      it 'returns the correct report' do
        expected = <<~REPORT
          Visits
          /home 3
          
          Unique visits
          /home 2
        REPORT
        expect(parser.report).to eq(expected)
      end
    end

    context 'when there is only one IP' do
      let(:log_file_path) { 'spec/fixtures/one_ip.log' }
  
      describe '.pages_by_visits' do
        it 'returns three results' do
          expect(parser.pages_by_visits.size).to eq(3)
        end
  
        it 'reports one visit each' do
          parser.pages_by_visits.each do | page |
            expect(page.split(' ').last).to eq('1')
          end
        end
      end
  
      describe '.pages_by_unique_visits' do
        it 'returns three results' do
          expect(parser.pages_by_unique_visits.size).to eq(3)
        end
  
        it 'reports one visit each' do
          parser.pages_by_unique_visits.each do | page |
            expect(page.split(' ').last).to eq('1')
          end
        end
      end

      describe '.report' do
        it 'returns the correct report' do
          expected = <<~REPORT
            Visits
            /page3 1
            /page2 1
            /page1 1
            
            Unique visits
            /page3 1
            /page2 1
            /page1 1
          REPORT
          expect(parser.report).to eq(expected)
        end
      end
    end
  end
end
