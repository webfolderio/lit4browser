npm install -f -g rollup
npm install -f -g typescript
mkdir -p build
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
npm install -g yarn
curl -L "https://github.com/mobxjs/mobx/archive/refs/tags/mobx@6.1.8.zip" --output 6.1.8.zip
unzip 6.1.8.zip
mv mobx-mobx-6.1.8 mobx
cd mobx
yarn run release
cp packages/mobx/dist/mobx.esm.development.js ../dist/mobx.esm.development.js
cp packages/mobx/dist/mobx.esm.development.js ../dist/mobx.esm.development.js.map
cp packages/mobx/dist/mobx.esm.production.min.js ../dist/mobx.esm.production.min.js
cp packages/mobx/dist/mobx.esm.production.min.js ../dist/mobx.esm.production.min.js.map
cd ..
curl -L "https://github.com/adobe/lit-mobx/archive/trunk.zip" --output trunk.zip
unzip trunk.zip
mv lit-mobx-trunk lit-mobx
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
