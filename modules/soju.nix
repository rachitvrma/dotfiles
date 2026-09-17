# Connect to soju from anywhere.
{
  flake.nixosModules.soju = {
    services.soju = {
      enable = true;
      listen = [ "irc+insecure://127.0.0.1:6667" ];
      adminSocket.enable = true;
    };
  };
}
