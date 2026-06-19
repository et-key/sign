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

export declare const f: <T extends SignValue, U extends SignValue>(foo: T | Hole, ...obj: U[]) => Atom;
export declare const g: <T extends SignValue, U extends SignValue, V extends SignValue>(foo: T | Hole, bar: U | Hole, ...obj: V[]) => Atom;
export declare const val1: SignValue;
export declare const val2: SignValue;
export declare const h: <T extends SignValue, U extends SignValue>(foo: T | Hole, ...obj: U[]) => Atom;
export declare const i: <T extends SignValue, U extends SignValue, V extends SignValue>(foo: T | Hole, bar: U | Hole, ...obj: V[]) => Atom;
export declare const val3: SignValue;
export declare const val4: SignValue;
export declare const dict_merge_test: List;
export declare const dict_type_error_test: List;
