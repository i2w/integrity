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

creds = YAML.load_file("creds.yml")

Integrity.configure do |c|
  c.user          creds['user']
  c.pass          creds['pass']
  c.github        creds['github']
  c.database      "sqlite3:integrity.db"
  c.directory     "builds"
  c.base_url      "http://integrity-i2w.no-ip.org"
  c.log           "integrity.log"
  c.builder       :dj, :adapter => "sqlite3", :database => "dj.db"
end
