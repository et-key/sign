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

export declare const func_with_defaults: <T extends SignValue, U extends SignValue>(x: T | Hole, y: U | Hole) => Atom;
export declare const result1_is_partial_applyed: <T extends SignValue>($p0: T | Hole) => SignValue;
export declare const result2_is_applied: SignValue;
export declare const result3_is_partial_applyed: List;
export declare const result4_is_applied: SignValue;
export declare const result5_is_applied: SignValue;
export declare const result6_is_applied: SignValue;
