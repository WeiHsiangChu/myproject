P_H = 0.1; %probability of winning each time is 0.1
gamma = 1;
states = 0:18;
V = zeros(1, length(states)); %create an array to store state values
policy = zeros(1, length(states)); %initialize policy for all states
theta = 1e-4;
iteration = 0; %initialize counter

for s = 11:length(states)
    V(s) = states(s);
end

while true
    iteration = iteration + 1; %count + 1 at the beginning
    delta = 0; %initialize delta

    for s = 2:10 %for 1 - 9 dollar
        v_old = V(s);
        best_value = -inf;
        best_action = 0;
        for a = 1:s-1 %for all actions
            s_win = s + a;
            s_lose = s - a;

            if s_win >= 11
                reward_win = s_win - 1; % reward equals to index - 1, which is the amount of money
                V_win = 0; %no future value
            else
                reward_win = 0;
                V_win = V(s_win);
            end
            
            if s_lose == 0
                reward_lose = 0;
                V_lose = 0;
            else
                reward_lose = 0;
                V_lose = V(s_lose);
            end
            
            q = P_H * (reward_win + gamma * V_win) + (1 - P_H) * (reward_lose + gamma * V_lose);; %calculate the state values for all actions
            if q > best_value %choose the action which has the highest state value
                best_action = a; %store the best action so far
                best_value = q; %store the best value so far
            end
        end
        V(s) = best_value; %assign the best value to new value
        policy(s) = best_action; %assign the best action to new policy
        delta = max(delta, abs(v_old - V(s))); %find the largest delta in the same state
    end

    if delta < theta %if state value after all actions are not changing that much
        break;
    end
end

format long
fprintf("Number of policy iterations: %d\n", iteration);
disp("Optimal value functions:");
disp(V);
disp("Optimal policy:");
disp(policy);