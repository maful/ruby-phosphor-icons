# frozen_string_literal: true

require "test_helper"

class TestPhosphorIcons < Minitest::Test
  def test_load_all_icon_on_initialization
    refute_equal(0, PhosphorIcons::ICON_SYMBOLS.length)
    alarm_icon = PhosphorIcons::ICON_SYMBOLS["alarm"]
    assert(alarm_icon["name"])
    assert(alarm_icon["styles"])
    assert(alarm_icon["styles"]["regular"])
    assert(alarm_icon["styles"]["regular"]["path"])
  end

  def test_fails_when_the_icon_doesn_t_exist
    assert_raises(PhosphorIcons::IconNotFoundError) do
      phosphor_icon("not-found")
    end
  end

  def test_accepts_a_string_for_an_icon
    icon = phosphor_icon("alarm")
    assert(icon)
  end

  def test_accepts_a_symbol_for_an_icon
    icon = phosphor_icon(:alarm)
    assert(icon)
  end

  def test_attributes_are_readable
    icon = phosphor_icon(:alarm)
    assert(icon.path)
    assert(icon.options)
    assert_equal("alarm", icon.symbol)
    assert_equal("regular", icon.style)
  end

  def test_has_view_box
    icon = phosphor_icon(:alarm)
    assert_includes(icon.to_svg, "viewBox=\"0 0 256 256\"")
  end

  def test_custom_classes
    icon = phosphor_icon(:alarm, class: "foo")
    assert_includes(icon.to_svg, "class=\"phosphor-icon foo\"")
  end

  def test_default_height
    icon = phosphor_icon(:alarm)
    assert_equal(24, icon.height)
    assert_equal(24, icon.width)
    assert_includes(icon.to_svg, "height=\"24\"")
    assert_includes(icon.to_svg, "width=\"24\"")
  end

  def test_custom_height
    icon = phosphor_icon(:alarm, height: 16)
    assert_equal(16, icon.height)
    assert_equal(16, icon.width)
    assert_includes(icon.to_svg, "height=\"16\"")
    assert_includes(icon.to_svg, "width=\"16\"")
  end

  def test_custom_height_with_closest_natural_height
    icon = phosphor_icon(:alarm, height: 21)
    assert_equal(20, icon.height)
    assert_equal(20, icon.width)
    assert_includes(icon.to_svg, "height=\"20\"")
    assert_includes(icon.to_svg, "width=\"20\"")
  end
end
