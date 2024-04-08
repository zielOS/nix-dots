cfdisk /dev/nvme0n1 && mkfs.vfat -F 32 /dev/nvme0n1p1 && fatlabel /dev/nvme0n1p1 NIXBOOT

cryptsetup --cipher aes-xts-plain64 --hash sha512 --use-random --verify-passphrase luksFormat /dev/nvme0n1p2 && cryptsetup luksOpen /dev/nvme0n1p2 cryptroot && mkfs.btrfs /dev/mapper/cryptroot -L NIXROOT 

mount /dev/disk/by-label/NIXROOT /mnt 

btrfs su cr /mnt/@  && btrfs su cr /mnt/@home && btrfs su cr /mnt/@tmp && btrfs su cr /mnt/@var && btrfs su cr /mnt/@log && btrfs su cr /mnt/@audit  && btrfs su cr /mnt//@nix && umount /mnt 

mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/disk/by-label/NIXROOT /mnt 

mkdir /mnt/home && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/disk/by-label/NIXROOT /mnt/home 

mkdir /mnt/tmp && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@tmp /dev/disk/by-label/NIXROOT /mnt/tmp 

mkdir /mnt/var && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@var /dev/disk/by-label/NIXROOT /mnt/var 

mkdir /mnt/var/log && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@log /dev/disk/by-label/NIXROOT /mnt/var/log 

mkdir /mnt/var/log/audit && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@audit /dev/disk/by-label/NIXROOT /mnt/var/log/audit 

mkdir /mnt/nix && mount -o noatime,compress=zstd,space_cache=v2,discard=async,subvol=@nix /dev/disk/by-label/NIXROOT /mnt/nix

mkdir -p /mnt/boot && mount /dev/disk/by-label/NIXBOOT /mnt/boot

sudo nixos-generate-config --root /mnt
