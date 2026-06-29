// alpha/rust/src/runtime.rs
use std::rc::Rc;
use std::collections::HashMap;
use std::fmt;

#[derive(Clone)]
pub enum SignValue {
    Unit,
    Hole,
    Scalar(f64),
    Char(char), // 文字・Unicodeコードポイント表現
    String(String),
    Address(usize),
    List(Vec<SignValue>),
    Dict(HashMap<String, SignValue>),
    Lambda(Rc<dyn Fn(Vec<SignValue>) -> SignValue>),
}

impl fmt::Debug for SignValue {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            SignValue::Unit => write!(f, "Unit"),
            SignValue::Hole => write!(f, "Hole"),
            SignValue::Scalar(s) => write!(f, "Scalar({})", s),
            SignValue::Char(c) => write!(f, "Char({:?})", c),
            SignValue::String(s) => write!(f, "String({:?})", s),
            SignValue::Address(a) => write!(f, "Address({:#x})", a),
            SignValue::List(l) => write!(f, "List({:?})", l),
            SignValue::Dict(d) => write!(f, "Dict({:?})", d),
            SignValue::Lambda(_) => write!(f, "Lambda(<closure>)"),
        }
    }
}

impl PartialEq for SignValue {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (SignValue::Unit, SignValue::Unit) => true,
            (SignValue::Hole, SignValue::Hole) => true,
            (SignValue::Scalar(a), SignValue::Scalar(b)) => a == b,
            (SignValue::Char(a), SignValue::Char(b)) => a == b,
            (SignValue::String(a), SignValue::String(b)) => a == b,
            (SignValue::Address(a), SignValue::Address(b)) => a == b,
            (SignValue::List(a), SignValue::List(b)) => a == b,
            (SignValue::Dict(a), SignValue::Dict(b)) => a == b,
            _ => false,
        }
    }
}

pub const UNIT: SignValue = SignValue::Unit;
pub const HOLE: SignValue = SignValue::Hole;

pub fn is_true(val: &SignValue) -> bool {
    match val {
        SignValue::Unit | SignValue::Hole => false,
        SignValue::List(l) if l.is_empty() => false,
        _ => true,
    }
}
