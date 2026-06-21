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

export declare const option: SignValue;
export declare const data: SignValue;
export declare const update: <T extends SignValue, U extends SignValue, V extends SignValue>(...option: T[], type: U | Hole, backend: V | Hole) => Unit;
