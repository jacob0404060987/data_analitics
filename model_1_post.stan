data {
    int<lower=0> N;  
    array[N] real<lower=0> engine_size;
    array[N] real<lower=0> drag_coeficient;
    array[N] real <lower=0> fuel_consumption;
}

parameters {
    real alpha;  
    real beta_engine_size;    
    real beta_drag_coeficient;  
    real<lower=0> sigma;  
}



model {
    
    alpha ~ normal(9.36, 2.29);  
    beta_engine_size ~ normal(0, 1);  
    beta_drag_coeficient ~ normal(0, 1);
    sigma ~ normal(0, 1);

    
    for(i in 1:N)
    {
    fuel_consumption[i] ~ normal(alpha + beta_engine_size * engine_size[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);
    }
}

generated quantities {
   array[N] real y_out;
   for(i in 1:N)
    {
    y_out[i] = normal_rng(alpha + beta_engine_size * engine_size[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);
    }
}