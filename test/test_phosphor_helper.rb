# frozen_string_literal: true

require "test_helper"

class TestPhosphorHelper < Minitest::Test
  include PhosphorIcons::Helper

  def test_renders_nothing_when_no_symbol_is_passed_in
    assert_equal("", phosphor_icon(nil))
  end

  def test_renders_the_svg
    assert_match(%r{<svg.*phosphor-icon.*>.*</svg>}, phosphor_icon("alarm"))
  end

  def test_has_a_path
    assert_match(/<path/, phosphor_icon("alarm"))
  end

  def test_caches_svgs
    PhosphorIcons::Helper.phosphor_icons_helper_cache = {}

    mock = Minitest::Mock.new
    # rubocop:disable Style/ClassVars
    def mock.path
      @@call_count ||= 0
      @@call_count += 1

      raise "PhosphorIcons library called twice" if @@call_count > 1

      "foo"
    end
    # rubocop:enable Style/ClassVars

    def mock.options; end

    PhosphorIcons::Icon.stub(:new, mock) do
      phosphor_icon("alarm")
      phosphor_icon("alarm")
    end

    PhosphorIcons::Helper.phosphor_icons_helper_cache = {}
  end
end
