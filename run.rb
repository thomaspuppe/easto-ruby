require 'fileutils'
require 'redcarpet'
require 'yaml'

filecounter = 0
Dir.foreach('content') do |item|
    next if item == '.' or item == '..'

    file_path = 'content/' + item
    file_content = File.read(file_path)

    page = File.read('templates/layout.html')

    # Split Metadata from Body
    file_splitted = file_content.split('-----')
    file_meta = file_splitted[0]
    file_body = file_splitted[1]

    meta = YAML.load(file_meta)
    meta.each do |key,value|
        if key == 'title'
            page = page.gsub('{{ META_TITLE }}', value)
        end
    end

    file_body = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(file_body)

    target_path = 'output/' + item.gsub('.md', '.html')
    target = open(target_path, 'w')
    
    page = page.gsub('{{ CONTENT_BODY }}', file_body)
    target.write(page)
    filecounter += 1
end

FileUtils.copy_entry('templates/static', 'output/static')

puts "You created #{filecounter} pages with easto. Congratulations!"