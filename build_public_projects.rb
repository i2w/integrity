# run this script via cron to build all public projects periodically (to be notified of failures by dependencies changing for example)

require File.dirname(__FILE__) + "/init"

Integrity::Project.all(:public => true).each do |p|
  Integrity.log "Building #{p.name} [via build_public_projects.rb script]"
  p.build("HEAD")
end
