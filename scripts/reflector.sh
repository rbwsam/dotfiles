sudo reflector --protocol https \
--country US \
--age 1 \
--latest 3 \
--sort rate \
--save /etc/pacman.d/mirrorlist
