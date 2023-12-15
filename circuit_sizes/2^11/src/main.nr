global N: Field = 512;

fn main(x: Field) {
    for i in 0 .. N {
        assert(x != x * i * 2);
    };
}
