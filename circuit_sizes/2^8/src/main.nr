global N = 64;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i as Field * 2);
    };
}
