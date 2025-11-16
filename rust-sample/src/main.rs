use rand::Rng;

fn main() {
    println!("Hello, world!");

    let randoms: Vec<u32> = generate_random_numbers(10);
    let mut input: Vec<u32> = generate_random_numbers(3);
    let mut mati = vec![0, 1, 2];

    let mut cnt: u32 = 0;

    println!("randoms: {:?}", randoms);

    while mati.len() > 0 {
        cnt = cnt + 1;

        println!("回数・一致した数: {}・{}", cnt, 3 - mati.len());
        println!("input: {:?}", input);

        for i in mati.clone() {
            if randoms.contains(&input[i]) {
                mati.retain(|&x| x != i);

            } else {
                input[i] = rand::rng().random_range(0..100);
            }
        }
    }
    println!("最終回数: {}", cnt);

}

fn generate_random_numbers(n: usize) -> Vec<u32> {
    (0..n).map(|_| rand::rng().random_range(0..100)).collect()
}

