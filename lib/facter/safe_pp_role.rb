require 'puppet'
require 'openssl'
Facter.add(:safe_pp_role) do
  setcode do
    # pick out the custom OID for pp_role, convert `:` to `_` and strip the leading `..` from the capture

    def read_extention(extentions)
      extentions.each do | element |
        if element.oid == 'pp_role' or element.oid == '1.3.6.1.4.1.34380.1.1.13'
          arr = (element.to_s).split(' ')
          arr.each | str | { puts "#{str}" }
          result = arr[2,arr.length].join
          return result
        end
      end
      # element not found
      return nil
    end

    cert_data = File.open "#{Puppet.settings[:certdir]}/#{Puppet.settings[:certname].downcase}.pem"

    certificate = OpenSSL::X509::Certificate.new cert_data

    result = read_extention(certificate.extensions)
    if result == nil
      safe_pp_role = nil
    else
      puts "Result is: #{result}"
      safe_pp_role = result.strip.gsub(/::/, '/').gsub(/^\./, '').gsub(/^\.\n/, '').gsub(/^\.\./, '')
    end
  
    safe_pp_role
  end
end