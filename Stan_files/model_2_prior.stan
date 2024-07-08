data{
    int N;
    array[N] real<lower=0> engine_size;
    array[N] real<lower=0> drag_coeficient;
    array[N] int<lower=0> cylinders;
}

generated quantities {
    real alpha;
    real beta_engine_size;
    real beta_cylinders;
    real beta_drag_coeficient;
    real  sigma;
    vector [N] fuel_consumption;

    alpha = normal_rng(9.36,2.29);
    beta_engine_size = normal_rng(0, 1);
    beta_cylinders = normal_rng(0, 1);
    beta_drag_coeficient = normal_rng(0, 1);
    sigma = normal_rng(2, 1);

        // sigma = exponential_rng(5);
    for(i in 1:N)
    {
        fuel_consumption[i] = normal_rng(alpha+beta_engine_size*engine_size[i]+beta_cylinders*cylinders[i]+beta_drag_coeficient*drag_coeficient[i],sigma);
    } 

}


