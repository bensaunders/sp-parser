# frozen_string_literal: true

require_relative './log_parser'

puts LogParser.new(ARGV[0]).report
