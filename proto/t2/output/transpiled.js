const x = 42;
const y = 10;
const sum = x + y;
const diff = x - y;
const product = x * y;
const quotient = x / y;
const calc1 = 10 + 20;
const calc2 = 5 * 3;
const calc3 = 100 - 25;
const calc4 = 50 / 2;
const complex1 = 10 + 20 * 3;
const complex2 = 100 - 50 / 2;
const complex3 = 2 * 3 + 4 * 5;
const power1 = Math.pow(2, 3);
const power2 = Math.pow(x, 2);
const power3 = Math.pow(2, 3) * 5;
const mod1 = 10 % 3;
const mod2 = 100 % 7;
const compare1 = (x < 50 ? x : NaN);
const compare2 = (y > 5 ? y : NaN);
const compare3 = (x === 42 ? x : NaN);
const compare4 = (10 <= 20 ? 10 : NaN);
const compare5 = (50 >= 30 ? 50 : NaN);
const compare6 = (x !== 0 ? x : NaN);
const a = 1;
const b = 0;
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
const result5 = grade(50);
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
      break;
    case xxx < 0:
      switch (true) {
        case yyy > 0: return "second quadrant";
        case yyy < 0: return "third quadrant";
        default: return "y-axis negative";
      }
      break;
    default:
      switch (true) {
        case yyy > 0: return "x-axis positive";
        case yyy < 0: return "x-axis negative";
        default: return "origin";
      }
      break;
  }
};
const result_2_1 = classify2D(5)(3);
const result_2_2 = classify2D(-5)(3);
const result_2_3 = classify2D(5)(-3);
const result_2_4 = classify2D(-5)(-3);
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
      break;
    default:
      switch (true) {
        case score >= 90: return "A";
        case score >= 80: return "B";
        default: return "C";
      }
      break;
  }
};
const result_2_7 = gradeWithBonus(85)(5);
const result_2_8 = gradeWithBonus(85)(0);
const increment = n => n + 1;
const double = n => n * 2;
const square = n => Math.pow(n, 2);
const lambda_result1 = increment(5);
const lambda_result2 = double(3);
const lambda_result3 = square(4);
const add = x => y => x + y;
const multiply = x => y => x * y;
const power = base => exp => Math.pow(base, exp);
const lambda_result4 = add(10)(20);
const lambda_result5 = multiply(3)(7);
const lambda_result6 = power(2)(8);
const sum3 = x => y => z => x + y + z;
const product3 = x => y => z => x * y * z;
const lambda_result9 = sum3(1)(2)(3);
const lambda_result10 = product3(2)(3)(4);
const addX = n => n + x;
const multiplyY = n => n * y;
const lambda_result11 = addX(10);
const lambda_result12 = multiplyY(5);