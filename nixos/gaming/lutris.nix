{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pkgs.lutris
  ];
}
