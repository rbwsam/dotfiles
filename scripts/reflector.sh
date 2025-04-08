sudo reflector \
--save /etc/pacman.d/mirrorlist \
--country "United States" \
--protocol https \
--latest 10 \
--fastest 3
