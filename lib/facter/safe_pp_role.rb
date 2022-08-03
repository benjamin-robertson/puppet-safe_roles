require 'puppet'
Facter.add(:safe_pp_role) do
  setcode do
    # pick out the custom OID for pp_role, convert `:` to `_` and strip the leading `..` from the capture
    safe_pp_role = nil

    puts "#{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"

    cert_data = File.open "#{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"

    certificate = OpenSSL::X509::Certificate.new cert_data

    extentions = certificate.extensions

    puts extentions

    # cert_data = Facter::Core::Execution.exec(
    #     "openssl x509 -text < #{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"
    # ).to_s.split(/\n/)

    # cert_data.each_with_index do |value, index|
    #   if value =~ /1.3.6.1.4.1.34380.1.1.13/
    #     safe_pp_role = cert_data[index+1].strip.gsub(/::/, '/').gsub(/^../, '')

    #     break
    #   end
    # end

    safe_pp_role
  end
end