# @summary A _safe_ version of the `os` structured fact
#
# This is required because the built-in fact suffers several idiosyncrasies:
# * Inconsistent capitalisation
# * Unwated spaces
# That make iterpolation into factor difficult, eg consider:
# * `os.family` Could be `RedHat` or `windows` (note capitalisation)
# * `os.release.major` Could be `7` or `2012 R2` (note spaces)
# If your interpolating the above into files for hiera, you could end up with
# files like:
# * /data/os/RedHat_7.yaml
# * /data/os/windows_2012 R2.yaml
# This is problematic, especially when dealing with case insensitive filesystems (windows, mac)
# Ideally we would be able to use:
# * /data/os/redhat_7.yaml
# * /data/os/windows_2012_r2.yaml
# Which this fact enables by downcasing all strings and replacing all spaces with underscores
Facter.add(:safe_os) do
  os = Facter.value(:os)

  def safe_os_cleanup(hash)
    hash.map { |k,v|
      case v
      when Hash then
        value = safe_os_cleanup(v)
      when String then
        value = v.dup
        value.downcase! ; value.gsub!(/ /, "_")
      else
        value = v.to_s
      end
      [k, value]
    }.to_h
  end

  setcode do
    safe_os_cleanup(os)
  end
end
