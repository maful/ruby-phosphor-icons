# frozen_string_literal: true

module PhosphorIcons
  class Icon
    DEFAULT_STYLE = "regular"
    SUPPORTED_STYLES = [DEFAULT_STYLE, "bold", "light", "duotone", "fill", "thin"]
    NATURAL_HEIGHTS = [16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80]
    DEFAULT_HEIGHT = 24

    attr_reader :symbol, :style, :options, :path, :width, :height

    def initialize(symbol, options = {})
      @symbol = symbol.to_s
      @style = options[:style] || DEFAULT_STYLE
      if (phosphor_icon = get_phosphor_icon(@symbol, options))
        @path = phosphor_icon["path"]
        @width = phosphor_icon["width"]
        @height = phosphor_icon["height"]
        @options = {
          class: "phosphor-icon #{options[:class]}".strip,
          viewBox: viewbox,
          xmlns: "http://www.w3.org/2000/svg",
          fill: "currentColor",
          width: @width,
          height: @height,
        }
      else
        raise IconNotFoundError, "Couldn't find #{self}"
      end
    end

    def to_svg
      "<svg #{html_attributes}>#{path}</svg>"
    end

    def to_s
      "Phosphor Icon for #{symbol.inspect} with style #{style.inspect}"
    end

    private

    def html_attributes
      attrs = ""
      options.each { |attr, value| attrs += "#{attr}=\"#{value}\" " }
      attrs.strip
    end

    def viewbox
      "0 0 256 256"
    end

    def get_phosphor_icon(symbol, options = {})
      if (phosphor_icon = PhosphorIcons::ICON_SYMBOLS[symbol])
        height = options[:height] || options[:width] || DEFAULT_HEIGHT
        natural_height = closest_natural_height(height)
        style = get_style(options[:style])

        {
          "name" => phosphor_icon["name"],
          "width" => natural_height,
          "height" => natural_height,
          "path" => phosphor_icon["styles"][style.to_s]["path"],
        }
      end
    rescue
      nil
    end

    def get_style(style)
      SUPPORTED_STYLES.include?(style.to_s) ? style : DEFAULT_STYLE
    end

    def closest_natural_height(height)
      NATURAL_HEIGHTS.reduce(NATURAL_HEIGHTS[0].to_i) do |acc, natural_height|
        natural_height.to_i <= height.to_i ? natural_height.to_i : acc
      end
    end
  end
end
