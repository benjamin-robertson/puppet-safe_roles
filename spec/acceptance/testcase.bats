@test "safe_role converted role OK" {
  grep "role/linux/webserver" /tmp/safe_role.txt
}

@test "safe_pp_role converted role OK" {
  grep "role/linux/oracle_server" /tmp/safe_pp_role.txt
}