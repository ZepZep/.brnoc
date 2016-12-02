monitor=LVDS1
projektor=HDMI1

kquitapp5 plasmashell
sleep 1
xrandr --output $projektor --auto --output $monitor --auto --primary --right-of $projektor
cp /home/brnoc/.brnoc/split.plasma-org.kde.plasma.desktop-appletsrc /home/brnoc/.config/plasma-org.kde.plasma.desktop-appletsrc
sleep 2
kstart5 plasmashell
