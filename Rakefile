# Rakefile for some common tasks
require 'puppet-syntax/tasks/puppet-syntax'
require 'pty'

VM_NAMES = %w(web)

# Set default task to speed up development, eg:
#task :default => ["module:sync", "vagrant:provision"]
#task :default do
  #Rake::Task["module:sync"].invoke
  #Rake::Task["vagrant:provision"].invoke("worker", "puppet")
#end

namespace :vagrant do
  desc "Rebuild vagrant VM.\nname: #{VM_NAMES.join(" | ")}"
  task :rebuild, :name do |t, args|
    pipe_exec "vagrant destroy #{args[:name]} -f"
    pipe_exec "vagrant up #{args[:name]} --provision"
  end

  desc "Provision vagrant VM.\nname: #{VM_NAMES.join(" | ")}\nprovisioner: shell | puppet"
  task :provision, :name, :provisioner do |t, args|
    if args[:provisioner] && args[:provisioner].length > 0
      pipe_exec "vagrant provision #{args[:name]} --provision-with #{args[:provisioner]}"
    else
      pipe_exec "vagrant provision #{args[:name]}"
    end
  end
end

namespace :module do
  desc "Clean and reinstall modules."
  task :reinstall do
    pipe_exec "librarian-puppet clean --verbose"
    pipe_exec "librarian-puppet install --verbose"
  end

  desc "Sync private modules."
  task :sync do
    path = File.dirname(__FILE__)
    puts "====== Removing private modules ======"
    `rm -rf #{path}/modules/role`
    `rm -rf #{path}/modules/profile`
    `ls #{path}/private | xargs -I {} rm -rf #{path}/modules/{}`
    puts "====== Copying private modules ======"
    `cp -R #{path}/role #{path}/modules/role`
    `cp -R #{path}/profile #{path}/modules/profile`
    `ls #{path}/private | xargs -I {} cp -R #{path}/private/{} #{path}/modules/{}`
  end

  desc "Puppet lint."
  task :lint do
    puts "====== Puppet lint role ======"
    pipe_exec "puppet-lint role"
    puts "====== Puppet lint profile ======"
    pipe_exec "puppet-lint profile"
    puts "====== Puppet lint manifests ======"
    pipe_exec "puppet-lint manifests"
  end
end

######## Helpers ########
#
def pipe_exec(command)
  begin
    PTY.spawn(command) do |stdin, stdout, pid|
      begin
        stdin.each { |line| print line }
      rescue Errno::EIO
      end
    end
  rescue PTY::ChildExited
    puts "The child process exited!"
  end
end
