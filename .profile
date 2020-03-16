export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/vim
if [ -d "$HOME/adb-fastboot/platform-tools"  ] ; then
     export PATH="$HOME/adb-fastboot/platform-tools/:$PATH"
fi
