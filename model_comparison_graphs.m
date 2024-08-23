% Data from the image provided
model_names = {'Original', 'default + ST', 'default + HM', '(default + ST) + HM', 'default + (ST + HM)'};
metrics = {'ST Pulses', 'ST Tonals', 'ST All', 'HM Pulses', 'HM Tonals', 'HM All'};
data = [
    0.376 0.145 0.131 0.131 0.058 0.063; % default
    0.673 0.62 0.53 0.234 0.119 0.129; % default + st
    0.254 0.183 0.132 0.863 0.806 0.754; % default + hm
    0.326 0.229 0.237 0.868 0.796 0.834; % (default + st) + hm
    0.943 0.949	0.749 0.854	0.8421 0.818 % default + (st + hm)
];

% Creating the bar graph
figure;
b = bar(data);

% Custom colors for each metric
colors = [
    0.8500 0.3250 0.0980; % orange for 'ST Pulses'
    0.9290 0.6940 0.1250; % yellow for 'ST Tonals'
    0.6350 0.0780 0.1840; % red for 'ST All'
    0 0.4470 0.7410; % blue for 'HM Pulses'
    0.3010 0.7450 0.9330; % cyan for 'HM Tonals'
    0.4940 0.1840 0.5560; % purple for 'HM All'
];

% Apply custom colors to each group of bars
for k = 1:length(b)
    b(k).FaceColor = colors(k,:);
    b(k).LineStyle = "none";
end

title('MAP50 Performance by Model and Metric');
xlabel('Model Name');
ylabel('MAP50');
xticklabels(model_names);
legend(metrics, 'Location', 'northeastoutside');
ylim([0 1]);
grid on;
