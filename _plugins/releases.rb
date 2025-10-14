Jekyll::Hooks.register :site, :post_read do |site|
  json = `gh release view --json tagName,assets`
  releases = JSON.parse(json)

  version = releases["tagName"]
  windows = releases["assets"].select{|i| i["url"].match("windows") }.first["url"]
  macos = releases["assets"].select{|i| i["url"].match("macos") }.first["url"]

  site.data["version"] = version
  site.data["windows"] = windows
  site.data["macos"] = macos

  puts site.data
end
