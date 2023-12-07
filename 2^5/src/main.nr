global N: Field = 8;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i * 2);
    };
}
