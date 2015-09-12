require "bundler/gem_tasks"

task :default => "test"

task :test do
  Dir.glob("test/test*.rb").each do |file|
    require_relative file
  end
end

task :examples do
  Dir.glob("examples/**.rb").each do |file|
    require_relative file
  end
end
