# frozen_string_literal: true

# A class for parsing web server logs
class LogParser
  def initialize(log_file_location)
    @log_file = File.new(log_file_location)
  end

  def counts
    return @counts if @counts
    counts = {}
    visits.each do | visit |
      counts[visit[:path]] ||= PathInfo.new
      counts[visit[:path]].add_visit visit[:ip]
    end
    @counts = counts
  end

  def visits
    return @visits if @visits
    visits = []
    @log_file.each do |line|
      visits << {
        path: line.split(' ').first,
        ip: line.split(' ').last
      }
    end
    @visits = visits
  end

  def pages_by_visits
    counts.sort_by{| k, v | v.visits }.reverse.map{|k, v| "#{k} #{v.visits}"}
  end

  def pages_by_unique_visits
    counts.sort_by{| k, v | v.unique_visits }.reverse.map{|k, v| "#{k} #{v.unique_visits}"}
  end

  def report
    <<~REPORT
    Visits
    #{pages_by_visits.join("\n")}

    Unique visits
    #{pages_by_unique_visits.join("\n")}
    REPORT
  end
end

class PathInfo
  attr_reader :visits

  def initialize
    @visits = 0
    @unique_visits = 0
    @ips = []
  end

  def add_visit(ip)
    @visits += 1
    @ips |= [ip]
  end

  def unique_visits
    @ips.size
  end
end