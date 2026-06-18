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

export declare const func: <T, U, V>(a: T | Hole, b: U | Hole, ...c: V[]) => List;
export declare const res: SignValue;
export declare const res2: SignValue;
