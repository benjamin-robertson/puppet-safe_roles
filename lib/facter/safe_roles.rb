# role -> safe_role
role = Facter.value(:role)
if role
  safe_role = role.gsub(/:/, '_')
  Facter.add(:safe_role)
    setcode do
      safe_role
    end
  end
end

# FIXME - add safe_pp_role another day...
#
# I'm in a hurry - here's how to do it
# pp_role -> safe_pp_role
#pp_role = 
  # certname = Facter::Core::Execution.exec(
  #  "openssl x509 -text < #{Puppet.settings[:certdir]}/#{Facter.value(:fqdn).downcase}.pem | awk -F'=' '/Subject: CN/ {print $2}'"
#).strip
