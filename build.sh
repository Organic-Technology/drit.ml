#


gzip -f -9 --keep *.html
gzip -f -9 --keep *.css
gzip -f -9 --keep *.js
gzip -f -9 --keep *.svg
gzip -f -9 --keep *.png

convert favicon.svg -resize 16x16 -strip favicon.png
pngquant -f --quality 0-50 --speed 1 --strip --verbose favicon.png
convert favicon.svg -resize 16x16 -strip favicon.webp

rm sizes*.webp
pngquant -f --quality 0-50 --speed 1 --strip --verbose sizes.png
convert sizes.png -quality 50 -strip sizes.png sizes.webp

git add *.gz
