# typed: false
# frozen_string_literal: true

require 'tmpdir'
require 'logger'

class Config
  def initialize(env_vars)
    @env_vars = env_vars
  end

  def storage_file_path
    @storage_file_path ||= resolve_storage_file_path
  end

  def logger
    @logger ||= init_logger
  end

  private

  attr_reader :env_vars

  def resolve_storage_file_path
    folder = env_vars.fetch('STORAGE_DIR', default_storage_dir)
    Dir.mkdir(folder) unless Dir.exist?(folder)
    file_name = env_vars.fetch('STORAGE_FILE_NAME', 'urls.csv')
    File.join(folder, file_name)
  end

  def init_logger
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    logger
  end

  def default_storage_dir
    File.join(Dir.tmpdir, "url-shortener-#{env_vars['RACK_ENV']}")
  end
end
