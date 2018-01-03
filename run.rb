require 'fileutils'
require 'redcarpet'
require 'yaml'

filecounter = 0
TEASERS = {}

Dir.foreach('content') do |item|
    next if item == '.' or item == '..'

    file_path = 'content/' + item
    file_content = File.read(file_path)

    page = File.read('templates/layout.html')

    teaser_html = File.read('templates/sub_index_article.html')

    # Split Metadata from Body
    file_splitted = file_content.split('-----')
    file_meta = file_splitted[0]
    file_body = file_splitted[1]

    TEASERS[item] = teaser_html

    meta = YAML.load(file_meta)
    meta.each do |key,value|
        replacement_string = "{{ META_" + key.upcase + " }}"
        page = page.gsub(replacement_string, value.to_s())

        TEASERS[item] = TEASERS[item].gsub(replacement_string, value.to_s())

    end

    file_body = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(file_body)

    target_path = 'output/' + item.gsub('.md', '.html')
    target = open(target_path, 'w')
    
    page = page.gsub('{{ CONTENT_BODY }}', file_body)
    target.write(page)
    filecounter += 1
end

# concat teaser HTML
teasers_html = TEASERS.values.join("\n\n")
index_body = 
index_target_path = 'output/index.html'
index_target = open(index_target_path, 'w')
index_page = File.read('templates/layout.html')
index_page = index_page.gsub('{{ CONTENT_BODY }}', teasers_html)
# just clean up for now
index_page = index_page.gsub('{{ META_TITLE }}', '')
index_page = index_page.gsub('{{ META_DATE }}', '')
# ... and output it to index.html
index_target.write(index_page)
filecounter += 1

FileUtils.copy_entry('templates/static', 'output/static')

puts "You created #{filecounter} pages with easto. Congratulations!"