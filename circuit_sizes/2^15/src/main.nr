global N: u32 = 8192;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i as Field * 2);
    };
}
