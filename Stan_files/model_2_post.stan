data {
    int<lower=0> N; 
    array[N] real<lower=0> engine_size;
    array[N] real<lower=0> drag_coeficient;
    array[N] int<lower=0> cylinders;
    array[N] real <lower=0> fuel_consumption;
}

parameters {

     real alpha;  
    real beta_engine_size;  
    real beta_cylinders;  
    real beta_drag_coeficient;  
    real<lower=0> sigma;  
}



model {


    alpha ~ normal(9.36, 2.29);  
    beta_engine_size ~ normal(0, 1);  
    beta_cylinders ~ normal(0, 1);
    beta_drag_coeficient ~ normal(0, 1);
    sigma ~ normal(0, 1);



    for(i in 1:N)
    {
    fuel_consumption[i] ~ normal(alpha+ beta_engine_size * engine_size[i] +
                              beta_cylinders * cylinders[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);
    }
}
generated quantities {
   array[N] real y_out;
    vector[N] log_lik;

   for(i in 1:N)
    {
            log_lik[i] = normal_lpdf(fuel_consumption[i] | alpha+beta_engine_size*engine_size[i]+beta_cylinders*cylinders[i]+beta_drag_coeficient*drag_coeficient[i], sigma);

    y_out[i] = normal_rng(alpha + beta_engine_size * engine_size[i] +
                              beta_cylinders * cylinders[i] +
                              beta_drag_coeficient * drag_coeficient[i], sigma);

    }
}