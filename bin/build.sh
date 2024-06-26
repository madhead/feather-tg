#!/bin/bash

# Create dist directory
npx rimraf dist
mkdir dist

# Build icons.json
npx babel-node bin/build-icons-json.js

# Build SVG sprite
npx babel-node bin/build-sprite.js

# Create dist/icons directory
npx rimraf dist/icons
mkdir dist/icons

# Build SVG icons
npx babel-node bin/build-svgs.js

# Build PNG icons
for svg in dist/icons/*.svg; do
    inkscape -w 100 -h 100 $svg -o "dist/icons/$(basename $svg .svg).png"
done

# Build JavaScript library
npx webpack --output-filename feather.js --mode development
npx webpack --output-filename feather.min.js --mode production
