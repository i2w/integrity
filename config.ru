require "init"

use Rack::Auth::Basic do |user, pass|
  user == "assy" && pass == "mcgee"
end

run Integrity.app
