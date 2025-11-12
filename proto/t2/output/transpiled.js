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