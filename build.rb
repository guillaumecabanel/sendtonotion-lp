require 'fileutils'

html_file = "index.html"
style_file = "style.css"

FileUtils.mkdir("site") unless File.exist?("site")

[html_file, style_file].each do |file|
  File.delete("site/#{file}") if File.exist?("site/#{file}")
  FileUtils.cp("src/#{file}", "site/#{file}")
end

style = File.read("site/#{style_file}")

minified_style = style.gsub(/\/.*\//, "")
minified_style = minified_style.gsub(/:\s/, ":")
minified_style = minified_style.gsub(/\s{/, "{")
minified_style = minified_style.gsub(/\n/, "")
minified_style = minified_style.gsub(/\s\s/, "")
minified_style = minified_style.gsub(/;}/, "}")

File.open("site/#{style_file}", "w") { |file| file.puts minified_style }

html = File.read("site/#{html_file}")

minified_html = html.gsub(/\n/, "")
minified_html = minified_html.gsub(/>\s*</, "><")

File.open("site/#{html_file}", "w") { |file| file.puts minified_html }
