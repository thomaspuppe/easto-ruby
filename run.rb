require 'fileutils'
require 'redcarpet'

filecounter = 0
Dir.foreach('content') do |item|
    next if item == '.' or item == '..'

    file_path = 'content/' + item
    file_content = File.read(file_path)

    file_content = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(file_content)

    target_path = 'output/' + item.gsub('.md', '.html')
    target = open(target_path, 'w')

    template = File.read('templates/layout.html')
    page = template.gsub('{{ CONTENT_BODY }}', file_content)
    target.write(page)
    filecounter += 1
end

FileUtils.copy_entry('templates/static', 'output/static')

puts "You created #{filecounter} pages with easto. Congratulations!"