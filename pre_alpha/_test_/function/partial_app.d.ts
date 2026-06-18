// Auto-generated TypeScript definitions for Sign

declare const __unit: unique symbol;
declare const __hole: unique symbol;
export type Unit = typeof __unit;
export type Hole = typeof __hole;
export type Scalar = number | boolean;
export type String = string;
export type Address = number;
export type Atom = Scalar | String | Hole | Address;
export type List = (Atom | List | Unit)[];
export type Lambda = (...args: SignValue[]) => SignValue;
export type SignValue = Atom | List | Lambda | Unit;

export declare const f: <T extends SignValue, U extends SignValue>(x: T | Hole, y: U | Hole) => Atom;
export declare const partial: <T extends SignValue>($p0: T | Hole) => SignValue;
export declare const curried: SignValue;
export declare const result_curried: SignValue;
export declare const check: Atom;
export declare const check2: Atom;
