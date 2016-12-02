monitor=LVDS1
projektor=HDMI1

kquitapp5 plasmashell
sleep 1
xrandr --output $monitor --auto --primary
cp /home/brnoc/.brnoc/one.plasma-org.kde.plasma.desktop-appletsrc /home/brnoc/.config/plasma-org.kde.plasma.desktop-appletsrc
sleep 2
kstart5 plasmashell
