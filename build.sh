#

find . -name '*~*' -delete
rm *.gz
if [ ! -e favicon.webp ]; then
convert favicon.svg -resize 16x16 -strip favicon.png
pngquant -f --quality 0-50 --speed 1 --strip --verbose favicon.png
convert favicon.svg -resize 16x16 -strip favicon.webp
fi

if [ ! -e size.webp ]; then
rm sizes*.webp
pngquant -f --quality 0-50 --speed 1 --strip --verbose sizes.png
convert sizes.png -quality 50 -strip sizes.png sizes.webp
fi

echo ipfs: archiving .
qm=$(ipfs add -r . -Q)
echo url: http://127.0.0.1:8080/ipfs/$qm
echo drit-key: $(ipfs key list -l | grep -w drit | cut -d' ' -f1)
key=k2k4r8n8d4u6iyutvmm7qj0c7cc560prs7vpqki7ygrald3ni3y6pkjt
emptyd=$(ipfs object new unixfs-dir)

qmdir=$(ipfs resolve /ipns/$key/www)
qmdir=${qmdir#/ipfs/}
qmdir=${qmdir:-$emptyd}
# remove folder nightly 
qmwww=$(ipfs object patch rm-link $qmdir nightly.drit.ml 2>/dev/null)
qmwww=${qmwww:-$qmdir}
# add new one
qmwww=$(ipfs object patch add-link $qmwww nightly.drit.ml $qm)
qmwww=${qmwww:-$emptyd}

qmdir=$(ipfs resolve /ipns/$key)
qmdir=${qmdir#/ipfs/}
qmdir=${qmdir:-$emptyd}
qmroot=$(ipfs object patch rm-link $qmdir www 2>/dev/null)
qmroot=${qmroot:-$qmdir}
qmroot=$(ipfs object patch add-link $qmroot www $qmwww)
ipfs name publish --key=drit $qmroot 1>/dev/null &
echo url: http://127.0.0.1:8080/ipfs/$qmroot/www/nightly.drit.ml/
echo url: http://127.0.0.1:8080/ipns/$key/www/nightly.drit.ml/
gzip -f -9 -n --keep *.html
gzip -f -9 -n --keep *.css
gzip -f -9 -n --keep *.js
gzip -f -9 -n --keep *.png
gzip -f -9 -n --keep *.svg
mv _logo.svg.gz logo.svg.gz
git add *.gz


