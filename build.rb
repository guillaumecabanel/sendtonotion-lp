require 'fileutils'
require 'erb'
require 'psych'

config = Psych.load(File.read("config.yml"), symbolize_names: true)

erb_files = %w[index.html sitemap.xml robots.txt]

erb_files.each do |file|
  erb = ERB.new(File.read("src/#{file}.erb"))
  File.open("site/#{file}", "w") { |file| file.puts erb.result }
end

html = File.read("site/index.html")

minified_html = html.gsub(/\n/, "")
minified_html = minified_html.gsub(/>\s*</, "><")

File.open("site/index.html", "w") { |file| file.puts minified_html }

FileUtils.cp("src/style.css", "site/style.css")
style = File.read("site/style.css")

minified_style = style.gsub(/\/.*\//, "")
minified_style = minified_style.gsub(/:\s/, ":")
minified_style = minified_style.gsub(/\s{/, "{")
minified_style = minified_style.gsub(/\n/, "")
minified_style = minified_style.gsub(/\s\s/, "")
minified_style = minified_style.gsub(/;}/, "}")

File.open("site/style.css", "w") { |file| file.puts minified_style }
