{ config, pkgs, lib, ... }:

{
  services.xserver.videoDrivers = [ "nvidia"];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    __Gl_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware = {
    nvidia = {
      open = false;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];
}
