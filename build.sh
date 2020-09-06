npm install -f -g rollup
npm install -f -g typescript
curl -L "https://github.com/Polymer/lit-element/archive/v2.4.0.zip" --output v2.4.0.zip
unzip -q v2.4.0.zip
mv lit-element-2.4.0 lit-element
curl -L "https://github.com/Polymer/lit-html/archive/v1.3.0.zip" --output v1.3.0.zip
unzip -q v1.3.0.zip
mv lit-html-1.3.0 lit-html
cp lit-html.js.patch lit-html/
cp lit-html-rollup.config.js lit-html/
cd lit-html
npm install -f --no-audit
npm run-script build
patch lit-html.js < lit-html.js.patch
rollup -c lit-html-rollup.config.js --no-treeshake
cd ..
cp lit-element-rollup.config.js lit-element/
cp lit-element.js.patch lit-element/
cd lit-element
npm install -f --no-audit
npm run-script build
patch lit-element.js < lit-element.js.patch
rollup -c lit-element-rollup.config.js --no-treeshake
cd ..
mv dist/lit-html.js dist/lit-html-1.3.0.js
mv dist/lit-html.iife.js dist/lit-html-1.3.0.iife.js
mv dist/lit-element.js dist/lit-element-2.4.0.js
mv dist/lit-element.iife.js dist/lit-element-2.4.0.iife.js