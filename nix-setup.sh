cfdisk /dev/nvme0n1

cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/nvme0n1p2 && cryptsetup config /dev/nvme0n1p2 --label cryptroot && cryptsetup luksOpen /dev/nvme0n1p2 enc-pv &&

pvcreate /dev/mapper/enc-pv && vgcreate vg /dev/mapper/enc-pv && lvcreate -L 8G -n swap vg && lvcreate -l '100%FREE' -n root vg

mkfs.fat -F 32 -n boot /dev/nvme0n1p1 && mkswap -L swap /dev/vg/swap && swapon /dev/vg/swap && mkfs.btrfs -L root /dev/vg/root

mount -t btrfs /dev/vg/root /mnt && btrfs su cr /mnt/@  && btrfs su cr /mnt/@home && btrfs su cr /mnt/@tmp && btrfs su cr /mnt/@var && btrfs su cr /mnt/@log && btrfs su cr /mnt/@audit  && btrfs su cr /mnt//@nix && umount /mnt

mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@ /dev/vg/root /mnt && mkdir /mnt/home && mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@home /dev/vg/root /mnt/home && mkdir /mnt/tmp && mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@tmp /dev/vg/root /mnt/tmp && mkdir /mnt/var && mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@var /dev/vg/root /mnt/var && mkdir /mnt/var/log && mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@log /dev/vg/root /mnt/var/log && mkdir /mnt/var/log/audit && mount -o noatime,compress=zstd,space_cache=v2,ssd,discard=async,subvol=@audit /dev/vg/root /mnt/var/log/audit && mkdir /mnt/nix && mount -o noatime,compress=zstd,space_cache=v2,discard=async,ssd,subvol=@nix /dev/vg/root /mnt/nix

mkdir -p /mnt/boot && mount /dev/nvme0n1p1 /mnt/boot

sudo nixos-generate-config --root /mnt

nixos-install --flake https://github.com/bara/myflake_repo#somehost

