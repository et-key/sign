const register_addr: usize = 0x8000000;

fn main() {
    // Running in Layer 0 (Bare Metal)
    unsafe { core::ptr::read_volatile(register_addr as *const f64) };
    unsafe { core::ptr::write_volatile(register_addr as *mut f64, 100.0) };
}
