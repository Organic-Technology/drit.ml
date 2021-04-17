#

original="bg-original.jpg"
b="bg-drit"
convert -strip -resize 1024x576 $original ${b}-color_576.jpg
convert -strip -resize 1024x576 $original -colorspace Gray ${b}-grey_576p.jpg
convert -strip -resize 1024x576 $original -colorspace Gray -interlace Plane -quality 40 ${b}-interlaced_576p.jpg
convert -depth 7 ${b}-grey_576p.jpg ${b}_576p.jpg ${b}_opt.webp

cp -p  ${b}_576p.jpg ${b}_jopt.jpg
jpegoptim --size=24 --strip-all  ${b}_jopt.jpg
convert ${b}_jopt.jpg ${b}_jopt.webp

ls -lS $f ${b}*.*
