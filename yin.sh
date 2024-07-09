#!/data/data/com.termux/files/usr/bin/bash
#guanyinlite

echo -e "\e[33mMenghentikan termux x11\e[0m"
kill -9 $(pgrep -f "termux.x11") 2>/dev/null

echo -e "\e[33mStart pulseaudio\e[0m"
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

echo -e "\e[33mMenyiapkan termux x11\e[0m"
export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/data/data/com.termux/files/home/x11-log-file.log &

sleep 5

echo -e "\e[33mLogin ke Debian dan cek update\e[0m"
proot-distro login debian --shared-tmp -- bash -c '
export PULSE_SERVER=127.0.0.1
export XDG_RUNTIME_DIR=${TMPDIR}
export DISPLAY=:0
apt update
apt install -y x11-xserver-utils fluxbox gkrellm xterm
mkdir -p ~/.fluxbox
echo "# Start GKrellM
gkrellm &
exec fluxbox" > ~/.fluxbox/startup
chmod +x ~/.fluxbox/startup

echo -e "\e[31;1mB\e[33;1mU\e[32;1mK\e[36;1mA \e[34;1mT\e[35;1mE\e[31;1mR\e[33;1mM\e[32;1mU\e[36;1mX \e[34;1mX\e[35;1m1\e[31;1m1 \e[33;1mS\e[32;1mE\e[36;1mK\e[34;1mA\e[35;1mR\e[31;1mA\e[33;1mN\e[32;1mG\e[36;1m. \e[34;1m. \e[35;1m.\e[0m"
startfluxbox
' &

sleep 5

if pgrep -f "termux.x11" > /dev/null; then
echo "Memulai Fluxbox OK..."
else
    echo "termux-x11 tidak berjalan. Periksa log di /data/data/com.termux/files/home/x11-log-file.log"
    exit 1
fi

if pgrep -f "fluxbox" > /dev/null; then
    echo "Fluxbox berjalan dengan benar"
else
    echo "Fluxbox tidak berjalan. Periksa log di /data/data/com.termux/files/home/fluxbox-error.log"
    tail -n 20 /data/data/com.termux/files/home/fluxbox-error.log
    exit 1
fi

exit 0