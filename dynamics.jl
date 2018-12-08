#println("====================================================")
#println("Dicke Hamiltonian")
#println("by Dr. Jorge Chavez Carlos")
using ODE;

function f(t, r)
    # Extract the coordinates from the r vector
    (p, q, P, Q) = r
    
    # The Hamilton equations
    dp_dt = -2*Q*sqrt(1 + (1/4)*(-P^2 - Q^2))*gamma - q*omega
    dq_dt = p*omega
    dP_dt = q*Q^2*gamma/(2*sqrt(1 - (1/4)*(P^2 + Q^2))) - 2*q*sqrt(1 - (1/4)*(P^2 + Q^2))*gamma - Q*omega0
    dQ_dt = -P*q*Q*gamma/(2*sqrt(1 - (1/4)*(P^2 + Q^2))) + P*omega0

    # Return the derivatives as a vector
    [dp_dt; dq_dt; dP_dt; dQ_dt]
end;
# Define time vector and interval grid
const dt = 0.01
const tf = 100.0
t = 0:dt:tf

# Initial position in space
const r0 = [0.0; -0.732332; 0.0; 1.22474]

# Constants sigma, rho and beta
const omega = 1.0
const omega0 = 1.0
const gamma = 1.0;
(t, pos) = ode45(f, r0, t)
p = map(v -> v[1], pos)
q = map(v -> v[2], pos)
P = map(v -> v[3], pos);
Q = map(v -> v[4], pos);
using PyPlot
plot3D(p, P, Q);
plot(Q, P);
fig, ax = subplots(1, 3, sharex=true, sharey=true, figsize=(16,8))

ax[1][:plot](Q, P)
ax[1][:set_title]("X-Y cut")
