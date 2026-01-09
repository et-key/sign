const { OperatorList, OperatorMap } = require('../../utility/operators.js');

console.log('OperatorList length:', OperatorList.length);
console.log('OperatorMap size:', OperatorMap.size);

const plusInfo = OperatorMap.get('+');
console.log('+ info from Map:', plusInfo);

const plusEntry = OperatorList.find(e => Object.keys(e)[0] === '+');
console.log('+ entry from List:', plusEntry);
