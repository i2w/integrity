set :path, File.expand_path(File.dirname(__FILE__))
set :output, File.expand_path(File.dirname(__FILE__) + '/integrity.log')

every 1.day, :at => "1:30am" do
  rake :clean_builds
end

every 1.day, :at => "1:40am" do
  rake :build_public_projects
end
