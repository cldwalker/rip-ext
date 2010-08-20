def current_version_path(path)
  "#{path}/.versions/#{Rip.md5(Rip.ruby)}"
end

def version_path(path)
  "#{path}/.versions/#{Rip.md5(ruby_version(path))}"
end

def ruby_version(pkg)
  File.read(pkg+'/build.rip').chomp
rescue Errno::ENOENT
  warn "Package `#{basename(pkg)}' is missing build.rip and needs to be rebuilt"
  nil
end

def name_from_path(path)
  path[/([^\/]+?)-.{32}$/, 1]
end