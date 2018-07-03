@test "safe_role converted role OK" {
  grep "role__linux__webserver" /tmp/safe_role.txt
}

@test "safe_pp_role converted role OK" {
  grep "role__linux__oracle_server" /tmp/safe_pp_role.txt
}