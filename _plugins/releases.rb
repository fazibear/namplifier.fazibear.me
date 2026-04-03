json = `gh release view --json tagName,assets`
releases = JSON.parse(json)

Jekyll::Hooks.register :site, :post_read do |site|
  version = releases["tagName"]
  windows = releases["assets"].select{|i| i["url"].match("windows") }.first["url"]
  macos = releases["assets"].select{|i| i["url"].match("macos") }.first["url"]
  linux = releases["assets"].select{|i| i["url"].match("linux") }.first["url"]

  site.data["version"] = version
  site.data["windows"] = windows
  site.data["macos"] = macos
  site.data["linux"] = linux

  puts site.data
end

Jekyll::Hooks.register :site, :post_write do |site|
  file = File.join(site.dest, 'current_version.txt')
  File.write(file, releases["tagName"])
end
