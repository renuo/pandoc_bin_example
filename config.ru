run do |env|
  [
    200,
    {"Content-Type" => "text/plain"},
    ["<html><body><pre>#{`pandoc --help`}</pre></body></html>"]
  ]
end
