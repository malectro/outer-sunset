import {promises as fs} from 'fs';

import colors from './colors.json';
import quantizeColor from './quantizeColor.mjs';


async function main() {
  const vimColors = Object.fromEntries(
    Object.entries(colors).map(([name, colorGroup]) => (
      [name, colorGroup.map(hash => ({gui: hash, cterm: quantizeColor(hashToRgb(hash))}))]
    ))
  );

  await fs.writeFile('./vimColors.json', JSON.stringify(vimColors, null, '  '));
  await fs.writeFile('./autoload/OuterSunset.vim',
`
let s:colors = ${JSON.stringify(vimColors)}

function! OuterSunset#GetColors()
  return s:colors
endfunction
`
  );
}
main();

function hashToRgb(hash) {
  const regex = /#(.{2})(.{2})(.{2})/;
  const parts = regex.exec(hash);
  return Array.from(Array(3).keys()).map(i => parseInt(parts[i + 1], 16));
}
