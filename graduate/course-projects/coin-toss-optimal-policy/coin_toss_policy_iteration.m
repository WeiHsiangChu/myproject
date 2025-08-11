P_H = 0.9; %the probability of winning each time is 0.9
gamma = 1;
states = 0:18; %0 - 18 dollars are possible
V = zeros(1, length(states)); %create an array to store our state values for each state(index 1 - 19)
policy = zeros(1, length(states)); %intialize policy
theta = 1e-4; 
iteration = 0; %counter

for s = 11:length(states) %the state values for money >= 10 are the amount of money
    V(s) = states(s);
end

while true %always
    iteration = iteration + 1; %add 1 to counter at the beginning of each iteration

    %policy evaluation
    while true
        delta = 0;
        for s = 2:10 %game starts whenever we have 1 - 9 dollars(index 2 - 10)
            a = policy(s); %the policy decides our bet
            if a == 0
                continue;
            end
            s_win = s + a; %index
            s_lose = s - a; %index

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
            
            v_new = P_H * (reward_win + gamma * V_win) + (1 - P_H) * (reward_lose + gamma * V_lose); %compute the new state value
            delta = max(delta, abs(v_new - V(s))); %tracks the largest value change during the entire loop over all states
            V(s) = v_new;
        end
        if delta < theta %if delta is small enough, meaning that the state values are not changing that much
            break;
        end
    end

    %policy improvement
    policy_stable = true; %set it as true at the beginning
    for s = 2:10 %1 - 9 dollars(index 2 - 10)
        old_action = policy(s); %store old action
        best_value = -inf;
        best_action = 0;
        for a = 1:s-1 %for all possible actions
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
        policy(s) = best_action; %update the policy
        if old_action ~= best_action
            policy_stable = false; %if the policy is changed, it's not stable
        end
    end
    if policy_stable %become stable whenever the policy is not changing anymore, then we know the best policy so far and go back to the evaluation again
            break;
    end
end

fprintf("Number of policy iterations: %d\n", iteration);
disp("Optimal value functions:");
disp(V);
disp("Optimal policy:");
disp(policy);

