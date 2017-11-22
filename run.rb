puts 'Hello Easto!'

puts 'Reading content directory'
Dir.foreach('content') do |item|
    next if item == '.' or item == '..'

    file_path = 'content/' + item
    puts '- found file ' + file_path

    file_content = File.read(file_path)
    puts '  - content: ' + file_content

    target_path = 'output/' + item.gsub('.md', '.html')
    target = open(target_path, 'w')

    template = File.read('templates/layout.html')
    page = template.gsub('{{ CONTENT_BODY }}', file_content)
    target.write(page)
    puts '- wrote file ' + target_path
end