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

export declare const list: List;
export declare const size: Atom;
export declare const first_item: Atom;
export declare const last_item: Atom;
export declare const last_item_at: Atom;
export declare const slice_range: Scalar;
export declare const residual: Unit;
export declare const arith_range_slice: Scalar;
export declare const geom_range_slice: Scalar;
export declare const infinite_range_slice: Scalar;
export declare const repeated: List;
export declare const lifted: List;
export declare const divided: List;
export declare const reversed: SignValue;
