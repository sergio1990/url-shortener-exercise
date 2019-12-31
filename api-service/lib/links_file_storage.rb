# frozen_string_literal: true

require 'csv'

class LinksFileStorage
  def initialize(file_path)
    @file_path = file_path
  end

  def load
    csv = CSV.open(file_path, 'r')
    csv.to_a.map do |row|
      Link.new(row[0], row[1])
    end
  rescue Errno::ENOENT
    []
  end

  def persist(links)
    CSV.open(file_path, 'w') do |csv|
      links.each do |link|
        csv << [link.full_url, link.short_prefix]
      end
    end
  end

  private

  attr_reader :file_path
end
