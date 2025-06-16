require "sinatra"

get "/" do
  "<html><body><pre>#{`pandoc --help`}</pre></body></html>"
end
