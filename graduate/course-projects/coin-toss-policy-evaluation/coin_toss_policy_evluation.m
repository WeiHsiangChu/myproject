p_H = 0.9;
gamma = 1;
maximum = 10;
theta = 1e-6;

%aggressive policy
v_aggressive = zeros(1, maximum + 1); %create an array to store value for all states($0 - $10)
v_aggressive(maximum + 1) = 1; %if state = $10, reward = 1

while true
    delta = 0; %reset at the beginning
    for s = 1: maximum-1 %loop for non-terminated states($1 - $9)
        old_v = v_aggressive(s+1); %store the value before updating
        bet = s; %aggressive
        win = min(s + bet, maximum); %win money, if s + bet > 10 then just make it = 10
        lose = max(s - bet, 0); %lose money, if s - bet < 0 then just make it = 0
        v_aggressive(s+1) = p_H * (gamma * v_aggressive(win+1)) + (1 - p_H) * (gamma * v_aggressive(lose+1)); %compute the new state-value based on probability
        delta = max(delta, abs(old_v - v_aggressive(s+1)));
    end
    if delta < theta %if it's not changing a lot after updating then stop
        break;
    end
end

disp('v_aggressive = ');
disp(v_aggressive);

%conservative policy
v_conservative = zeros(1, maximum + 1); %create an array to store value for all states($0 - $10)
v_conservative(maximum + 1) = 1; %if state = $10, reward = 1

while true
    delta = 0; %reset at the beginning
    for s = 1: maximum-1 %loop for non-terminated states($1 - $9)
        old_v = v_conservative(s+1); %store the value before updating
        bet = 1; %conservative
        win = min(s + bet, maximum); %win money, if s + bet > 10 then just make it = 10
        lose = max(s - bet, 0); %lose money, if s - bet < 0 then just make it = 0
        v_conservative(s+1) = p_H * (gamma * v_conservative(win+1)) + (1 - p_H) * (gamma * v_conservative(lose+1)); %compute the new state-value based on probability
        delta = max(delta, abs(old_v - v_conservative(s+1)));
    end
    if delta < theta %if it's not changing a lot after updating then stop
        break;
    end
end

disp('v_conservative = ');
disp(v_conservative);

%random policy
v_random = zeros(1, maximum + 1); %create an array to store value for all states($0 - $10)
v_random(maximum + 1) = 1; %if state = $10, reward = 1

while true
    delta = 0; %reset at the beginning
    for s = 1: maximum-1 %loop for non-terminated states($1 - $9)
        old_v = v_random(s+1); %store the value before updating
        bets = 1:s; %all possible bet
        v_sum = 0; %reset
        for b = bets
            win = min(s + b, maximum); %win money, if s + bet > 10 then just make it = 10
            lose = max(s - b, 0); %lose money, if s - bet < 0 then just make it = 0
            value = p_H * (gamma * v_random(win+1)) + (1 - p_H) * (gamma * v_random(lose+1));
            v_sum = v_sum + (1 / length(bets)) * value;
        end
        v_random(s+1) = v_sum; %compute the new state-value based on probability
        delta = max(delta, abs(old_v - v_random(s+1)));
    end
    if delta < theta %if it's not changing a lot after updating then stop
        break;
    end
end

disp('v_random = ');
disp(v_random);