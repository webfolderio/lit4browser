npm install -f -g rollup
npm install -f -g typescript
curl -L "https://github.com/Polymer/lit-element/archive/v2.3.1.zip" --output v2.3.1.zip
unzip -q v2.3.1.zip
mv lit-element-2.3.1 lit-element
curl -L "https://github.com/Polymer/lit-html/archive/v1.2.1.zip" --output v1.2.1.zip
unzip -q v1.2.1.zip
mv lit-html-1.2.1 lit-html
cd lit-html
npm install -f --no-audit
patch lit-html.js < ../lit-html.js.patch
rollup -c ../lit-html-rollup.config.js --no-treeshake
cd ..
cd lit-element
npm install -f --no-audit
patch --binary lit-element.js < ../lit-element.js.patch
rollup -c ../lit-element-rollup.config.js --no-treeshake
mv dist/lit-html.js dist/lit-html-1.2.1.js  
mv dist/lit-html.iife.js dist/lit-html-1.2.1.iife.js  
mv dist/lit-element.js dist/lit-element-2.3.1.js  
mv dist/lit-element.iife.js dist/lit-element-2.3.1.iife.js  