const wabt = require('wabt')();
const fs = require('fs');

wabt.then((w) => {
  const wat = fs.readFileSync('test_stack.wat', 'utf8');
  try {
    const module = w.parseWat('test_stack.wat', wat);
    module.resolveNames();
    module.validate();
    console.log("Valid!");
  } catch(e) {
    console.error(e.message);
  }
});
