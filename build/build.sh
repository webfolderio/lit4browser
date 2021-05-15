
npm install -f -g rollup
npm install -f -g typescript
mkdir -p build
git clone https://github.com/lit/lit-element.git
git clone https://github.com/lit/lit.git
mv lit lit-html
cd lit-html
git checkout -b lit-html-1.x
git checkout 39a00486fee64277a630666fde08cddc9a2402c9
cd ..
cp lit-html.js.patch lit-html/
cp lit-html-rollup.config.js lit-html/
cd lit-html
npm install -f --no-audit
npm run-script build
patch lit-html.js < lit-html.js.patch
rollup -c lit-html-rollup.config.js --no-treeshake
cd ..
cp lit-element.js.patch dist/
cp lit-element-rollup.config.js lit-element/
cd lit-element
npm install -f --no-audit
npm run-script build
rollup -c lit-element-rollup.config.js --no-treeshake
cd ..
cd dist
patch --verbose --ignore-whitespace --fuzz 3 lit-element.js < lit-element.js.patch
rm -f lit-element.js.patch
cd ..
git clone https://github.com/adobe/lit-mobx.git
cd lit-mobx
git checkout bf88b667ca792574ba7e0b34441cec4abf58eeb8
cd ..
cp lit-mobx-rollup.config.js lit-mobx/src/
cp lit-mobx.js.patch dist/
cd lit-mobx
npm install -f --no-audit
npm run-script build
cd src
rollup -c lit-mobx-rollup.config.js --no-treeshake
cd ..
cd ..
cd dist
patch --verbose --ignore-whitespace --fuzz 3 lit-mobx.js < lit-mobx.js.patch
rm -f lit-mobx.js.patch
cd ..
