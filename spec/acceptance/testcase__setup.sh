mkdir -p /etc/puppetlabs/puppet/ssl/certs/
cp /testcase/spec/testdata/node.pem /etc/puppetlabs/puppet/ssl/certs/$(facter fqdn| awk '{print tolower($0)}').pem