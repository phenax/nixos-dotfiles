const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

const getTabBtnSelector = type => `[href="/cheatsheet/free/${type}"]`;


const types = ['solid', 'regular', 'brands'];

async function start() {
  const b = await puppeteer.launch({ headless: true });

  const p = await b.newPage();

  console.log('Downloading...');
  await p.goto('https://fontawesome.com/cheatsheet/free/solid');

  const icons = {};

  for (const type of types) {
    await p.click(getTabBtnSelector(type));

    const data = await p.evaluate((type) => {
      const getClass = type => ({
        solid: '.fas',
        regular: '.far',
        brands: '.fab',
      })[type];

      return [...document.querySelectorAll(`section article`)]
        .map($el => ({
          label: $el.id,
          icon: $el.querySelector(getClass(type)).textContent,
          // group: type,
        }));
    }, type);

    icons[type] = data;
  }

  b.close();

  console.log('Saving to icons...');
  Object.entries(icons).forEach(([type, icons]) => {
    const iconsContent = icons
      .map(({ label, icon, group }) => `${icon}|${label}`)
      .join('\n');

    fs.writeFileSync(path.resolve(__dirname, `icons/${type}`), iconsContent);
  });
}

start();

