{

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "M1BDD" ];
    ensureUsers = [ { name = "M1BDD"; } ];
  };

  services.monetdb = {
    enable = true;
  };

}
