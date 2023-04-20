{ pkgs, lib, ... }: {
  home.packages = lib.mkAfter [ pkgs.ruby_3_1 ];
}
