require 'fileutils'

html_file = "index.html"
style_file = "style.css"

FileUtils.mkdir("dist") unless File.exist?("dist")

[html_file, style_file].each do |file|
  File.delete("dist/#{file}") if File.exist?("dist/#{file}")
  FileUtils.cp(file, "dist/#{file}")
end

style = File.read("dist/#{style_file}")

minified_style = style.gsub(/\/.*\//, "")
minified_style = minified_style.gsub(/:\s/, ":")
minified_style = minified_style.gsub(/\s{/, "{")
minified_style = minified_style.gsub(/\n/, "")
minified_style = minified_style.gsub(/\s\s/, "")
minified_style = minified_style.gsub(/;}/, "}")

File.open("dist/#{style_file}", "w") { |file| file.puts minified_style }

html = File.read("dist/#{html_file}")

minified_html = html.gsub(/\n/, "")
minified_html = minified_html.gsub(/>\s*/, ">")


File.open("dist/#{html_file}", "w") { |file| file.puts minified_html }
