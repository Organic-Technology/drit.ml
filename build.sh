#


gzip -f --keep *.html
gzip -f --keep *.css
gzip -f --keep *.js
gzip -f --keep *.svg
gzip -f --keep *.png

rm sizes*.webp
pngquant -f --quality 0-50 --speed 1 --strip --verbose sizes.png
convert sizes.png -quality 50 -strip sizes.png sizes.webp

git add *.gz
