# frozen_string_literal: true

require "action_view"

module PhosphorIcons
  module Helper
    include ActionView::Helpers::TagHelper

    mattr_accessor :phosphor_icons_helper_cache, default: {}

    # rubocop:disable Style/IdenticalConditionalBranches
    def phosphor_icon(symbol, options = {})
      return "" if symbol.nil?

      cache_key = [symbol, options]

      if (tag = phosphor_icons_helper_cache[cache_key])
        tag
      else
        icon = PhosphorIcons::Icon.new(symbol, options)

        tag = content_tag(:svg, icon.path.html_safe, icon.options).freeze
        phosphor_icons_helper_cache[cache_key] = tag
        tag
      end
    end
    # rubocop:enable Style/IdenticalConditionalBranches
  end
end
