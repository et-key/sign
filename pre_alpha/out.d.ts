// Auto-generated TypeScript definitions for Sign

declare const __unit: unique symbol;
declare const __hole: unique symbol;
export type Unit = typeof __unit;
export type Hole = typeof __hole;
export type Scalar = number | string | boolean;
export type Address = number;
export type Atom = Scalar | Hole | Address;
export type List = (Atom | List | Unit)[];
export type Lambda = (...args: any[]) => SignValue;
export type SignValue = Atom | List | Lambda | Unit;

export declare const add: <T, U>(x: T | Hole, y: U | Hole) => Atom;
export declare const fold_eager: <T, U, V, W>(f: T | Hole, a: U | Hole, x: V | Hole, ...y: W[]) => SignValue;
export declare const map: <T, U, V>(g: T | Hole, x: U | Hole, ...y: V[]) => List;
export declare const num: Atom;
