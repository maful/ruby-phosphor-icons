# frozen_string_literal: true

require "rails"

module PhosphorIcons
  class Railtie < Rails::Railtie
    initializer "phosphor_icons_helper.helper" do
      ActionView::Base.send(:include, PhosphorIcons::Helper)
    end
  end
end
