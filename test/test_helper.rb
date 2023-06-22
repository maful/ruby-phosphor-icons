# frozen_string_literal: true

require "minitest/autorun"
require "phosphor_icons"

def phosphor_icon(symbol, options = {})
  PhosphorIcons::Icon.new(symbol, options)
end
