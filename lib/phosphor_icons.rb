# frozen_string_literal: true

require "phosphor_icons/version"
require "phosphor_icons/icon"
require "phosphor_icons/helper"
require "phosphor_icons/railtie" if defined?(Rails)
require "json"

module PhosphorIcons
  file_data = File.read(File.join(File.dirname(__FILE__), "./build/data.json"))
  ICON_SYMBOLS = JSON.parse(file_data).freeze

  class IconNotFoundError < StandardError; end
end
