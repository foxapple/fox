#!/bin/sh

if ! command -v fox >/dev/null 2>&1; then
  echo "[fox] fox is not installed."
  exit 1
fi

read -r -p "[fox] are you sure you want to uninstall fox? [y/N]" confirmation
if [ "$confirmation" != y  ] && [ "$confirmation" != Y ]; then
    echo "[fox] uninstall cancelled"
    exit
fi

if [[ -z $FOX_NAME ]]; then
    echo "[fox] fox environment variables is not initialized. Please check if you have executed \`source ~/.zshrc\`"
    exit 1
fi
source $FOX_COMMON/dependency.sh

unregister_fox_dependency

_TARGET="/usr/local/bin"
_TARGET_FOX="${_TARGET}/${FOX_NAME}"
rm $_TARGET_FOX
rm .foxrc
sed -i '' '/.foxrc/d' ~/.zshrc

source $FOX_COMMON/logo.sh
source $FOX_COMMON/utils.sh

# Uninstall success
success ""
success ""
print_logo
success "                                                                   ... is now uninstall!"
success ""
success "        Thanks for trying out fox."
success "        Byeeeeeee!"
success ""
success ""
