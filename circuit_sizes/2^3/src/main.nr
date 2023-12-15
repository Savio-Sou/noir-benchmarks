global N: Field = 1;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i * 2);
    };
}
