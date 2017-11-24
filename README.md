# easto
A static-site generator

## Run

Create the output: `ruby run.rb`

Start a local webserver at http://localhost:8000/ :

    `ruby -rwebrick -e'WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => Dir.pwd+"/output").start'`

Kudos to https://gist.github.com/willurd/5720255

## Deploy

Copy `output` folder to `gh-pages` branch.

    git subtree push --prefix output origin gh-pages

(https://gist.github.com/cobyism/4730490)
