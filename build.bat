npm install -g rollup
npm install -g typescript
npm install -g tsc
git clone https://github.com/Polymer/lit-html.git
cd lit-html
npm install
patch lit-html.js < ../lit-html.js.patch
rollup -c ../lit-html-rollup.config.js --no-treeshake
cd ..
git clone https://github.com/Polymer/lit-element.git
cd lit-element
npm install
patch lit-element.js < ../lit-element.js.patch
rollup -c ../lit-element-rollup.config.js --no-treeshake