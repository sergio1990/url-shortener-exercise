# typed: false
# frozen_string_literal: true

require 'csv'
require 'logger'

class LinksFileStorage
  def initialize(file_path, logger = Logger.new(nil))
    @file_path = file_path
    @logger = logger
  end

  def load
    logger.info("Starts to load links from #{file_path}")
    csv = CSV.open(file_path, 'r')
    csv.to_a.map do |row|
      Link.new(row[0], row[1])
    end
  rescue Errno::ENOENT => e
    logger.error("Failed to load links from #{file_path}: #{e.message}")
    []
  end

  def persist(links)
    logger.info("Starts to persist links to #{file_path}")
    CSV.open(file_path, 'w') do |csv|
      links.each do |link|
        csv << [link.full_url, link.short_prefix]
      end
    end
  end

  private

  attr_reader :file_path, :logger
end
