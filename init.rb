$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require ".bundle/environment"
require "integrity"

# Uncomment as appropriate for the notifier you want to use
# = Email
require "integrity/notifier/email"
# = IRC
# require "integrity/notifier/irc"
# = Campfire
# require "integrity/notifier/campfire"

Integrity.configure do |c|
  c.user          "assy"
  c.pass          "mcgee"
  c.database      "sqlite3:integrity.db"
  c.directory     "builds"
  c.base_url      "http://integrity-i2w.no-ip.org"
  c.log           "integrity.log"
  c.github        "AssyMcIntegritee"
  c.builder       :dj, :adapter => "sqlite3", :database => "dj.db"
end
