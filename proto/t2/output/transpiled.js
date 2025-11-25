// Helper functions
function range(start, end, step) {
  const result = [];
  // stepが未指定の場合、自動判定
  if (step === undefined) {
    step = start <= end ? 1 : -1;
  }
  if (step > 0) {
    for (let i = start; i <= end; i += step) {
      result.push(i);
    }
  } else {
    for (let i = start; i >= end; i += step) {
      result.push(i);
    }
  }
  return result;
}

function Sign_factorial(n) {
  if (n < 0) return NaN;
  if (n === 0 || n === 1) return 1;
  let result = 1;
  for (let i = 2; i <= n; i++) {
    result *= i;
  }
  return result;
}

const x = 42;
const y = 10;
const a = 1;
const b = 0;
const n = 5;
const sum = x + y;
const diff = x - y;
const product = x * y;
const quotient = x / y;
const arith_complex1 = 10 + 20 * 3;
const arith_complex2 = 100 - 50 / 2;
const arith_complex3 = 2 * 3 + 4 * 5;
const power1 = Math.pow(2, 3);
const power2 = Math.pow(x, 2);
const power3 = Math.pow(2, 3) * 5;
const mod1 = 10 % 3;
const compare1 = (x < 50 ? x : NaN);
const compare2 = (y > 5 ? y : NaN);
const compare3 = (x === 42 ? x : NaN);
const compare4 = (10 <= 20 ? 10 : NaN);
const compare5 = (50 >= 30 ? 50 : NaN);
const compare6 = (x !== 0 ? x : NaN);
const logic1 = (a && b);
const logic2 = (a || b);
const logic3 = ((a || b) && !(a && b));
const logic4 = ((x > 0 ? x : NaN) && (x < 100 ? x : NaN));
const logic5 = ((y === 0 ? y : NaN) || (y === 10 ? y : NaN));
const xx = 42;
const yy = -5;
const classify = xx => {
  switch (true) {
    case xx < 0: return "negative";
    case xx === 0: return "zero";
    case xx > 0: return "positive";
  }
};
const result1 = classify(xx);
const result2 = classify(yy);
const mySc = xx => yy => {
  switch (true) {
    case xx < 0: return xx * -1;
    case xx === 0: return yy;
    case xx > 0: return xx;
  }
};
const result3 = mySc(xx)(yy);
const score = 85;
const grade = score => {
  switch (true) {
    case score >= 90: return "A";
    case score >= 80: return "B";
    case score >= 70: return "C";
    case score >= 60: return "D";
    default: return "F";
  }
};
const result4 = grade(score);
const xxx = 5;
const yyy = 3;
const classify2D = xxx => yyy => {
  switch (true) {
    case xxx > 0:
      switch (true) {
        case yyy > 0: return "first quadrant";
        case yyy < 0: return "fourth quadrant";
        default: return "y-axis positive";
      }
    case xxx < 0:
      switch (true) {
        case yyy > 0: return "second quadrant";
        case yyy < 0: return "third quadrant";
        default: return "y-axis negative";
      }
    default:
      switch (true) {
        case yyy > 0: return "x-axis positive";
        case yyy < 0: return "x-axis negative";
        default: return "origin";
      }
  }
};
const result_2_1 = classify2D(5)(3);
const result_2_2 = classify2D(-5)(3);
const result_2_5 = classify2D(0)(5);
const result_2_6 = classify2D(0)(0);
const gradeWithBonus = score => bonus => {
  switch (true) {
    case bonus > 0:
      switch (true) {
        case score >= 85: return "A";
        case score >= 75: return "B";
        default: return "C";
      }
    default:
      switch (true) {
        case score >= 90: return "A";
        case score >= 80: return "B";
        default: return "C";
      }
  }
};
const result_2_7 = gradeWithBonus(85)(5);
const result_2_8 = gradeWithBonus(85)(0);
const increment = n => n + 1;
const square = n => Math.pow(n, 2);
const lambda_result1 = increment(5);
const add = x => y => x + y;
const multiply = x => y => x * y;
const lambda_result4 = add(10)(20);
const lambda_result5 = multiply(3)(7);
const quadratic = a => b => c => x => a * Math.pow(x, 2) + b * x + c;
const distance = x1 => y1 => x2 => y2 => Math.pow(x2 - x1, 2) + Math.pow(y2 - y1, 2);
const lambda_result7 = quadratic(1)(2)(3)(5);
const lambda_result8 = distance(0)(0)(3)(4);
const sum3 = x => y => z => x + y + z;
const lambda_result9 = sum3(1)(2)(3);
const addX = n => n + x;
const lambda_result11 = addX(10);
const list1 = [1, 2, 3];
const list2 = [10, 20, 30, 40];
const list3 = [x, y, sum];
const emptyList = [];
const singleList = [42];
const range1 = range(1, 5);
const range3 = range(10, 1);
const range4 = range(-5, 5);
const concat1 = [...list1, ...list2];
const concat2 = [...[1, 2], ...[3, 4]];
const doubled = list1.map(x => x * 2);
const squared = list1.map(x => Math.pow(x, 2));
const sum_list = list1.reduce((acc, x) => acc + x);
const product_list = list1.reduce((acc, x) => acc * x);
const spread1 = sum3(...list1);
const map_then_fold = list1.map(x => x * 2).reduce((acc, x) => acc + x);
const custom_map1 = list1.map(n => n * 3);
const complex_map1 = [1, 2, 3].map(x => x * 2 + 1);
const nested_2d = [[1, 2], [3, 4]];
const nested_flat = [...[1, 2], ...[3, 4]];
const first = list1[0];
const slice1 = list2.slice(0, 3);
const fib_sum = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55].reduce((acc, x) => acc + x);
const squares = range(1, 10).map(x => Math.pow(x, 2));
const not1 = !a;
const not3 = !undefined;
const not4 = (!((x > 0 ? x : NaN)));
const neg1 = -x;
const neg4 = (-(x + y));
const fact1 = Sign_factorial(5);
const fact3 = Sign_factorial(0);
const fact4 = Sign_factorial(n);
const abs1 = Math.abs(x);
const abs4 = Math.abs((x - y));
const unary_combo1 = (!((x < 50 ? x : NaN)));
const unary_combo3 = Math.pow(-2, 3);
const unary_combo4 = (-(Math.pow(2, 3)));
const unary_combo5 = Math.abs(x) + Math.abs(y);
const unary_complex1 = (!a || !b);
const unary_complex2 = (!((a && b)));
const unary_complex4 = (-(Math.abs(x)));
const negate = x => -x;
const absolute = x => Math.abs(x);
const factorial = n => Sign_factorial(n);
const logicalNot = x => !x;
const apply1 = negate(10);
const apply2 = absolute(-20);
const config = {
  host: "localhost",
  port: 3000,
  debug: !undefined
};
const person = {
  profile: {
  name: "Alice",
  age: 30
},
  contact: {
  email: "alice@example.com"
}
};
const host_value = config.host;
const person_name = person.profile.name;
const person_email = person.contact.email;
const single = {
  value: 42
};
const mixed = {
  items: [1, 2, 3],
  count: 3
};
const data = {
  x_value: x,
  y_value: y,
  sum_value: sum
};