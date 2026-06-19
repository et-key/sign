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

export declare const a: Atom;
export declare const b: Atom;
export declare const c: Atom;
export declare const d: Atom;
export declare const e: Atom;
export declare const f: Atom;
export declare const g: Atom;
export declare const h: Atom;
export declare const i: Atom;
export declare const j: Atom;
export declare const k: Atom;
export declare const l: Atom;
export declare const m: Atom;
