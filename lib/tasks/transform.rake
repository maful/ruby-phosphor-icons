# frozen_string_literal: true

desc "Transform icons to JSON object"
namespace :transform do
  task :icons do
    require "ox"
    require "json"

    REGEX_FILENAME = /^(.+?)(?:-(bold|light|duotone|fill|thin))?\.svg$/
    INPUT_ARG = "core/assets/**/*.svg"
    OUTPUT_FILE = "lib/build/data.json"

    def build_path(obj)
      doc = Ox::Document.new
      obj.each do |k, v|
        top = Ox::Element.new(k)
        v.each do |pk|
          pk.each { |jk, jv| top[jk] = jv }
        end
        doc << top
      end
      Ox.dump(doc).strip
    end

    def recursive_merge(origin, other)
      origin.merge(other) { |_k, v1, v2| v1.is_a?(Hash) && v2.is_a?(Hash) ? recursive_merge(v1, v2) : v2 }
    end

    icons = Dir[INPUT_ARG].map do |filepath|
      filename = File.basename(filepath)
      match_filename = REGEX_FILENAME.match(filename)
      svg_element = Ox.load(File.read(filepath), mode: :hash)[:svg]
      svg_path = svg_element[1..].map { |s| build_path(s) }.join("")

      {
        name: match_filename[1],
        style: match_filename[2] || "regular",
        path: svg_path,
      }
    end

    icons_by_name = icons.reduce({}) do |acc, icon|
      recursive_merge(acc, {
        icon[:name] => {
          name: icon[:name],
          styles: {
            icon[:style] => { path: icon[:path] },
          },
        },
      })
    end

    folder_path = File.dirname(OUTPUT_FILE)
    FileUtils.mkdir_p(folder_path)

    File.open(OUTPUT_FILE, "w") do |f|
      f.write(icons_by_name.to_json)
    end
  end
end
