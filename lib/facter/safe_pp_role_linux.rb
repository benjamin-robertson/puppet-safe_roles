require 'puppet'
Facter.add(:safe_pp_role) do

  setcode do
    # pick out the custom OID for pp_role, convert `:` to `_` and strip the leading `..` from the capture
    Facter::Core::Execution.exec(
      "openssl x509 -text < #{Puppet.settings[:certdir]}/#{Facter.value(:fqdn).downcase}.pem | awk 'f{print;f=0} /1.3.6.1.4.1.34380.1.1.13/{f=1}'"
    ).strip.gsub(/::/, '/').gsub(/^../, '')
  end
end