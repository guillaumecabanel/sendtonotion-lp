require 'fileutils'
require 'erb'
require 'psych'


FileUtils.mkdir("site") unless File.exist?("site")

FileUtils.cp("src/style.css", "site/style.css")
style = File.read("site/style.css")

minified_style = style.gsub(/\/.*\//, "")
minified_style = minified_style.gsub(/:\s/, ":")
minified_style = minified_style.gsub(/\s{/, "{")
minified_style = minified_style.gsub(/\n/, "")
minified_style = minified_style.gsub(/\s\s/, "")
minified_style = minified_style.gsub(/;}/, "}")

File.open("site/style.css", "w") { |file| file.puts minified_style }

config = Psych.load(File.read("config.yml"), symbolize_names: true)

erb = ERB.new(File.read("src/index.html.erb"))
File.open("site/index.html", "w") { |file| file.puts erb.result }
html = File.read("site/index.html")

minified_html = html.gsub(/\n/, "")
minified_html = minified_html.gsub(/>\s*</, "><")

File.open("site/index.html", "w") { |file| file.puts minified_html }
