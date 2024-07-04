data {
    int<lower=0> N;  // liczba obserwacji
    array[N] real<lower=0> engine_size;
    array[N] real<lower=0> drag_coeficient;
    array[N] int<lower=0> cylinders;
    array[N] real <lower=0> fuel_consumption;
}

parameters {
    real alpha;  // intercept
    real beta_engine_size;  // coefficient for engine size
    real beta_cylinders;  // coefficient for cylinders
    real beta_drag_coeficient;  // coefficient for drag coefficient
    real<lower=0> sigma;  // residual standard deviation
}

model {
    // Priors
    alpha ~ normal(9.36, 2.29);  // środek i rozrzut konsumpcji paliwa
    beta_engine_size ~ normal(0, 1);  // rozkład standardowy dla wag predyktorów
    beta_cylinders ~ normal(0, 1);
    beta_drag_coeficient ~ normal(0, 1);
    sigma ~ normal(0, 1);

    // Likelihood
    for(i in 1:N)
    {
    fuel_consumption[i] ~ normal(alpha + beta_engine_size * engine_size[i] +
                              beta_cylinders * cylinders[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);
    }
}

generated quantities {
   array[N] real y_out;
   for(i in 1:N)
    {
    y_out[i] = normal_rng(alpha + beta_engine_size * engine_size[i] +
                              beta_cylinders * cylinders[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);
    }
}