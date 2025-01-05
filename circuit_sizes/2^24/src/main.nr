global N: u32 = 4194304;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i as Field * 2);
    };
}
