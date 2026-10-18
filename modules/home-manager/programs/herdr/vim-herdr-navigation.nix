{ pkgs }:
pkgs.fetchFromGitHub {
  owner = "paulbkim-dev";
  repo = "vim-herdr-navigation";
  rev = "742db891e7d1f9a550b16c01dc8a6763f2b1493a";
  hash = "sha256-Yt82HBBOdY4tjvZVREpQzKoEklJY0aIYU5ZzISdf7fg=";
}
