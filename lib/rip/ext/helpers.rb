module Rip
  module Ext
    module Helpers
    extend self

    def current_ruby_version_path(path)
      "#{path}/.versions/#{Rip.md5(Rip.ruby)}"
    end

    def active_version_path(path)
      "#{path}/.versions/#{Rip.md5(ruby_version(path))}"
    end

    def ruby_version(path)
      File.read(path+'/build.rip').chomp
    rescue Errno::ENOENT
      warn "Package `#{File.basename(path)}' is missing build.rip and needs to be rebuilt"
      nil
    end

    def name_from_path(path)
      path[/([^\/]+?)-.{32}$/, 1]
    end

    def find_symlink_parent(file)
      while parent = File.dirname(file)
        return parent if File.symlink?(parent)
        return nil if parent == '/'
        file = parent
      end
    end

    def read_embedded_symlink(file)
      (parent = find_symlink_parent(file)) && file.sub(parent, File.readlink(parent))
    end

    def find_extension_packages
      Dir[Rip.dir+'/**/*/**/*.bundle'].inject({}) {|acc,e|
        if (env = e[/^#{Rip.dir}\/([^\/]+)/, 1]) && env != 'active'
          realfile = File.symlink?(e) ? File.readlink(e) : read_embedded_symlink(e)
          if (pkg = realfile.to_s[/^(#{Rip.packages}\/[^\/]+)/, 1])
            (acc[env] ||= []) << pkg
          end
        end
        acc
      }
    end
    end
  end
end