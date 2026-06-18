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
export type Lambda = (...args: any[]) => SignValue;
export type SignValue = Atom | List | Lambda | Unit;

export declare const f: <T>(x: T | Hole) => Atom;
export declare const add: <T, U>(x: T | Hole, y: U | Hole) => Atom;
export declare const fold: <T, U, V, W>(f: T | Hole, a: U | Hole, x: V | Hole, ...xs: W[]) => SignValue;
export declare const a: SignValue;
export declare const b: SignValue;
