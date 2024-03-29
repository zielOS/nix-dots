{pkgs, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    nvidia = {
      open = false;
      powerManagement.enable = true;
      modesetting.enable = true;
    };
    opengl.setLdLibraryPath = true;
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
