let
  krish = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILr6f7ueKKJXVpLkCWsoGGZit3j0EzpsqOBXFG/1bBkB";
in
{
  "ytmusic-client-id.age".publicKeys = [ krish ];
  "ytmusic-client-secret.age".publicKeys = [ krish ];
}
