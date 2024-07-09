echo
echo "SETTING UP AUR SOFTWARE"
echo

echo "Please enter username:"
read username

cd "${HOME}"

echo "CLONING: YAY"
git clone "https://aur.archlinux.org/yay.git"

cd ${HOME}/yay
makepkg -si

echo
echo "Yay setup complete."
echo