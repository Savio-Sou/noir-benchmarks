global N = 2097152;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i as Field * 2);
    };
}
