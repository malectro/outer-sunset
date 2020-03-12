import colors from './cterm-colors.json';

export default function quantizeColor(color) {
  let bestMatch;
  let bestMatchDistance = Infinity;

  for (let ctermColor of colors) {
    const distance = ctermColor.rgb.reduce((acc, val, index) => acc + Math.abs(val - color[index]), 0);
    if (distance < bestMatchDistance) {
      bestMatch = ctermColor;
      bestMatchDistance = distance;
    }
  }

  return bestMatch;
}
