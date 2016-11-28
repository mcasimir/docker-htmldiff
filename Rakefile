require "uri"
require "net/http"

VERSION = File.read('VERSION').strip

task :build do
  docker "build -t mcasimir/htmldiff:v#{VERSION} ."
  docker "tag mcasimir/htmldiff:v#{VERSION} mcasimir/htmldiff:latest"
  puts green "✔ Built mcasimir/htmldiff:v#{VERSION}"
end

task :push => :test do
  puts "Pushing mcasimir/htmldiff:v#{VERSION}"
  docker "push mcasimir/htmldiff:v#{VERSION}"
  puts green "✔ Pushed mcasimir/htmldiff:v#{VERSION}"
end

task :test => :build do
  PORT = 4568
  docker 'rm', '-f', 'htmldiff_test'
  docker 'run', '--name htmldiff_test', '-d', "-p #{PORT}:4567", "mcasimir/htmldiff:v#{VERSION}"
  sleep 1

  response = Net::HTTP.post_form(
    URI("http://localhost:#{PORT}/diff"),
    {"html1" => "<h1>Foo</h1>", "html2" => "<h1>Bar</h1>"}
  )

  docker 'rm', '-f', 'htmldiff_test'
  expectation = "<h1><del class=\"diffmod\">Foo</del><ins class=\"diffmod\">Bar</ins></h1>"

  if response.body != expectation
    puts red "✘ Test failed"
    puts red "#{response.body} != #{expectation}"
    exit 1
  else
    puts green "✔ Test passed"
  end
end

def docker(*args); puts `docker #{args.join(' ')}` rescue nil; end
def red(str);            "\e[31m#{str}\e[0m" end
def green(str);          "\e[32m#{str}\e[0m" end
