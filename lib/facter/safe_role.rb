# @summary A _safe_ version of the `role` structured fact, if it exists
#
# The conversion process replaces any `::` with `/` so that we can form paths in hiera
role = Facter.value(:role)
if role
  safe_role = role.gsub(/::/, '/')
  Facter.add(:safe_role) do
    setcode do
      safe_role
    end
  end
end
