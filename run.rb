filecounter = 0
Dir.foreach('content') do |item|
    next if item == '.' or item == '..'

    file_path = 'content/' + item
    file_content = File.read(file_path)

    target_path = 'output/' + item.gsub('.md', '.html')
    target = open(target_path, 'w')

    template = File.read('templates/layout.html')
    page = template.gsub('{{ CONTENT_BODY }}', file_content)
    target.write(page)
    filecounter += 1
end

puts "You created #{filecounter} pages with easto. Congratulations!"