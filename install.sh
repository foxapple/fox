#!/bin/zsh

set -e

if command -v fox >/dev/null 2>&1; then
    echo "[fox] fox is already installed."
    exit 1
fi

export FOX_ROOT=`pwd`
export FOX_NAME="fox"
export FOX_COMMON=$FOX_ROOT/common
export FOX_CONFIG=$FOX_ROOT/config
export FOX_SCRIPTS=$FOX_ROOT/scripts
export FOX_TEMPLATES=$FOX_ROOT/templates
source $FOX_COMMON/logo.sh
source $FOX_COMMON/utils.sh
source $FOX_COMMON/dependency.sh

echo "[fox] ========================================"
echo "[fox] fox may trigger \`brew update\`, please waiting for a while if it triggered."

# installing dependencies
echo "[fox] ========================================"
echo "[fox] start register fox dependencies..."
register_fox_dependency

# installing fox
echo "[fox] ========================================"
echo "[fox] start installing \`fox\`..."
_TARGET="/usr/local/bin"
_TARGET_FOX="${_TARGET}/${FOX_NAME}"
ln -s $FOX_ROOT/fox.sh $_TARGET_FOX

# initialize .foxrc
echo "[fox] ========================================"
echo "[fox] start initializing \`.foxrc\`..."
echo "" > .foxrc
echo "export FOX_ROOT=\"$FOX_ROOT\"" >> .foxrc
echo "export FOX_NAME=\"$FOX_NAME\"" >> .foxrc
echo "export FOX_COMMON=\"$FOX_COMMON\"" >> .foxrc
echo "export FOX_CONFIG=\"$FOX_CONFIG\"" >> .foxrc
echo "export FOX_SCRIPTS=\"$FOX_SCRIPTS\"" >> .foxrc
echo "export FOX_TEMPLATES=\"$FOX_TEMPLATES\"" >> .foxrc
echo "fpath=($FOX_ROOT/fpath \$fpath)" >> .foxrc
echo "autoload -U compinit" >> .foxrc
echo "compinit" >> .foxrc
echo "unfunction _fox" >> .foxrc
echo "autoload -U _fox" >> .foxrc
echo "source $FOX_ROOT/.foxrc" >> ~/.zshrc

# building completions
echo "[fox] ========================================"
echo "[fox] start building completions for \`fox\`..."
fox system build -s

# initialize config.yaml
echo "[fox] ========================================"
echo "[fox] start initializing \`$FOX_CONFIG/config.yaml\`..."
if [[ -e $FOX_CONFIG/config.yaml ]]; then
    # backup previous config.yaml
    timestamp=$(date "+%Y%m%d-%H%M%S")
    backupfile=".config-backup-$timestamp.yaml"
    cat $FOX_CONFIG/config.yaml > $FOX_CONFIG/$backupfile
fi
cp $FOX_TEMPLATES/config-template.yaml $FOX_CONFIG/config.yaml
ldap=`git config user.email | sed "s/@.*//g"`
gsed -i "s/^#ldap: [a-z]*/ldap: $ldap/" $FOX_CONFIG/config.yaml

# Install success
success ""
success ""
print_logo
success "                                                                   ... is now installed!"
success ""
success "        Before you use fox! Please execute \"source ~/.zshrc\" to make sure that the fox configurations are ready!"
success ""
success "        • The project is technically supported by @baochuquan"
success "        • View fox on github: https://github.com/baochuquan/fox"
success "        • View wiki on github: https://github.com/baochuquan/fox-wiki"
success "        • Follow author: http://chuquan.me"
success "        • If you have any problem or suggestion, please contact me. Email: baochuquan@163.com"
success ""