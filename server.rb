require 'htmldiff'
require 'sinatra'

include HTMLDiff

set :environment, :production

post '/diff' do
  content_type "text/html"
  diff(params["html1"], params["html2"])
end
