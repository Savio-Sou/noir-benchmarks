global N: Field = 4194304;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i * 2);
    };
}
