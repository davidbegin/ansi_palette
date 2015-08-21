require "bundler/gem_tasks"

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
