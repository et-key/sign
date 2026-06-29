fn add(x: f64, y: f64) -> f64 {
    (x + y)
}

fn partial_add(y: f64) -> f64 {
    (move |y| add(10.0, y))(y)
}

fn main() {
    // Running in Layer 2 (OS Std)
    println!("partial_add 20 = {}", partial_add(20.0));
}
