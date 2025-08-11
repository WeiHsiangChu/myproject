tic;
runs = 2000;
steps = 1000;
k = 10;
epsilon = 0.1;
c = 2;

%initialize array that store rewards
all_reward_greedy = zeros(runs, steps);
all_reward_ucb = zeros(runs, steps);

for r = 1:runs %loop for 2000 runs
    true_value_q = randn(1, k); %true value for each action should be set randomly at start of each run

    %initialize estimates and number of times has been chosen
    Q_greedy = zeros(1, k);
    N_greedy = zeros(1, k);
    Q_ucb = zeros(1, k);
    N_ucb = zeros(1, k);
    for t = 1:steps %loop for 1000 steps
        %epsilon greedy
        if rand < epsilon
            a_greedy = randi(k); %choose random action between 1 and k
        else
            [~, a_greedy] = max(Q_greedy); %max function returns the maximum value and the index, ~ means ignore the maximum value
        end
        reward_greedy = true_value_q(a_greedy) + randn; %generate reward for selected action with true value + noise
        N_greedy(a_greedy) = N_greedy(a_greedy) + 1; %number of times +1
        Q_greedy(a_greedy) = Q_greedy(a_greedy) + (reward_greedy - Q_greedy(a_greedy)) / N_greedy(a_greedy); %use the given equation to calculate the new estimate
        all_reward_greedy(r, t) = reward_greedy; %store each reward into an array so we can then compute the average rewards through 2000 runs

        %UCB
        if any(N_ucb == 0) %if there's an action hasn't been selected
            a_ucb = find(N_ucb == 0, 1); %select the one that hasn't been selected
        else
            ucb_values = Q_ucb + c * sqrt(log(t) ./ N_ucb); %otherwise choose the one has larger ucb_values, it might have lower N or higher Q
            [~, a_ucb] = max(ucb_values); %only need the index
        end
        reward_ucb = true_value_q(a_ucb) + randn; %generate reward for selected action with true value + noise
        N_ucb(a_ucb) = N_ucb(a_ucb) + 1; %number of times +1
        Q_ucb(a_ucb) = Q_ucb(a_ucb) + (reward_ucb - Q_ucb(a_ucb)) / N_ucb(a_ucb); %use the given equation to calculate the new estimate
        all_reward_ucb(r, t) = reward_ucb; %store each reward into an array so we can then compute the average rewards through 2000 runs
    end
end

%compute the mean across rows for each step
average_reward_greedy = mean(all_reward_greedy, 1);
average_reward_ucb = mean(all_reward_ucb, 1);

%plot
plot(1:steps, average_reward_greedy, 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
hold on
plot(1:steps, average_reward_ucb, 'b', 'LineWidth', 1.5)
xlabel('Steps', 'FontSize', 14)
ylabel('Average reward', 'FontSize', 14)
legend('\epsilon-greedy  \epsilon = 0.1', 'UCB  c = 2', 'FontSize', 12, 'Location', 'southeast')
xlim([1 steps])
ylim([0 1.5])
grid on
toc;