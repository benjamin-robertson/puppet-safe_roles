# role -> safe_role
role = Facter.value(:role)
if role
  safe_role = role.gsub(/::/, '/')
  Facter.add(:safe_role) do
    setcode do
      safe_role
    end
  end
end
