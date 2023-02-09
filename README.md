# Proof-of-concept verification of a NixOS system

Work-in-progress. Intended to be tied into secure boot.

```shell
$ nixos-rebuild build-vm --flake .#vm
$ ./result/bin/run-nixos-vm

# After logging in (username: root, password: changeme), run
$ tune2fs -O verity /dev/vda
$ reboot
# Then fs-verity and composefs should be available on the machine at least.
```

[This post](https://lkml.org/lkml/2023/1/20/1212) seems to suggest what I want may be possible using overlayfs+erofs (after implementing additional features in those filesystems...)
This discussion seems pretty contentious, to say the least.
Watch for replies to [this](https://lkml.org/lkml/2023/2/6/1111)
