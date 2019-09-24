x0 = [0;0];


plot_props = {'LineWidth', 2, 'MarkerSize', 8};

[t, y] = ode45(@my_ode, [0 48], x0);

figure
subplot(2, 1, 1)
plot(t, y(:, 1),'-r', plot_props{:});
hold on
plot(t, y(:, 2), '-b', plot_props{:});
legend('mRNA', 'protein')
xlabel('Time [h]');
ylabel('Concentration');
grid on
set(gca, 'XMinorGrid','off', 'YMinorGrid','off', 'GridAlpha',0.6, 'GridLineStyle', '--')
set(gca,'FontSize',20);



[t, y] = ode45(@my_ode, [0 1000], x0);

subplot(2, 1, 2)
plot(t, y(:, 1),'-r', plot_props{:});
hold on
plot(t, y(:, 2), '-b', plot_props{:});
legend('mRNA', 'protein')
xlabel('Time [h]');
ylabel('Concentration');
grid on
set(gca, 'XMinorGrid','off', 'YMinorGrid','off', 'GridAlpha',0.6, 'GridLineStyle', '--')
set(gca,'FontSize',20);