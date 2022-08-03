require 'puppet'
Facter.add(:safe_pp_role) do
  setcode do
    # pick out the custom OID for pp_role, convert `:` to `_` and strip the leading `..` from the capture
    safe_pp_role = nil

    def read_extention(extentions)
      extentions.each do | element |
        if element.oid == 'pp_role'
          arr = (element.to_s).split(' ')
          result = arr[2,arr.length].join
          return result
        end
      end
    end

    puts "#{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"

    cert_data = File.open "#{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"

    certificate = OpenSSL::X509::Certificate.new cert_data

    result = read_extention(certificate.extensions)

    puts result
    puts result.class

    if result.is_a? String
      safe_pp_role = result.strip.gsub(/::/, '/').gsub(/^../, '')
      puts safe_pp_role
  
      safe_pp_role
    else
      puts 'why am i here?'
      'facter is dumb'
    end
  end
end