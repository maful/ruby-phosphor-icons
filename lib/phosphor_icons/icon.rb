# frozen_string_literal: true

module PhosphorIcons
  class Icon
    DEFAULT_STYLE = "regular"
    SUPPORTED_STYLES = [DEFAULT_STYLE, "bold", "light", "duotone", "fill", "thin"]

    attr_reader :symbol, :style, :options, :path

    def initialize(symbol, options = {})
      @symbol = symbol.to_s
      @style = options[:style] || DEFAULT_STYLE
      if (phosphor_icon = get_phosphor_icon(@symbol, options))
        @path = phosphor_icon["path"]
        @options = {
          class: "phosphor-icon #{options[:class]}".strip,
          viewBox: viewbox,
          xmlns: "http://www.w3.org/2000/svg",
          fill: "currentColor",
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
        style = get_style(options[:style])

        {
          "name" => phosphor_icon["name"],
          "path" => phosphor_icon["styles"][style.to_s]["path"],
        }
      end
    rescue
      nil
    end

    def get_style(style)
      SUPPORTED_STYLES.include?(style.to_s) ? style : DEFAULT_STYLE
    end
  end
end
