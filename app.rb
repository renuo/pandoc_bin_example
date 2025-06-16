class App
  def self.call(env)
    [
      200,
      {"Content-Type" => "text/html"},
      ["<html><body><pre>#{`pandoc --help`}</pre></body></html>"]
    ]
  end
end
