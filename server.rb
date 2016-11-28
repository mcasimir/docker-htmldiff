require 'htmldiff'
require 'sinatra'

include HTMLDiff

set :environment, :production

post '/diff' do
  content_type "text/html"

  html1 = params["html1"] || ""
  html2 = params["html2"] || ""

  if html1.instance_of?(Hash)
    html1 = html1[:tempfile].read
  end

  if html2.instance_of?(Hash)
    html2 = html2[:tempfile].read
  end

  diff html1, html2
end
