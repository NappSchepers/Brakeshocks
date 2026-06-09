function EMTBR_4CP_new(fn_pvsrs, pvsrs_maximax)
figure; % open new figure
hold on;

% 4CP PVSRS plot without GUI-Handles
EMTBR_4CP(fn, pvsrs, 8); % Size_2 = 8 z.B.

% plottig data (overlayed on EMTBR_4CP)
loglog(fn, pvsrs, 'k', 'LineWidth', 1);

% axis title and  formatting
title('PVSRS Q=10', 'FontName', 'Arial', 'FontWeight', 'normal', 'FontSize', 16, 'Interpreter', 'none');
xlabel('Frequency (Hz)', 'FontName', 'Arial', 'FontSize', 14, 'Interpreter', 'none');
ylabel('Pseudo-Velocity (m/s)', 'FontName', 'Arial', 'FontSize', 14, 'Interpreter', 'none');

set(gca, 'XLim', [100 10000], 'YLim', [0.01 30]);
set(gca, 'FontSize', 12);

grid on;
hold off;

function EMTBR_4CP(F, PV, Size_2)
    % color spec
    color_spec1 = [0 0 0];
    color_spec2 = [0.7 0.7 0.7];

    % frequency limit low and high
    fl = 10; % alt: 100
    fr = 100000; % alt: 30000
    flr = [fl fr];

    % set axis limits
    xlim([100, 30000]);
    ylim([0.01, 30]);

    % constants
    kl = 2 * pi * fl;
    kr = 2 * pi * fr;

    % Major acceleration and displacement lines
    for i = 1:10
        g_dec(i,:) = [1*10^i/kl, 1*10^i/kr];
        z_dec(i,:) = [1*10^(-i)*kl, 1*10^(-i)*kr];
    end

    hold on;

    % Minor acceleration lines (m/s^2)
    z = 1;
    for i = 1:10
        for k = 2:9
            g_dec_minor(z,:) = g_dec(i,:) * k;
            loglog(flr, g_dec_minor(z,:), 'LineWidth', 0.1, 'Color', color_spec2);
            z = z + 1;
        end
    end

    % Minor displacement lines (m)
    z = 1;
    for i = 1:10
        for k = 2:9
            z_dec_minor(z,:) = z_dec(i,:) * k;
            loglog(flr, z_dec_minor(z,:), 'LineWidth', 0.1, 'Color', color_spec2);
            z = z + 1;
        end
    end

    % Major lines on top
    for j = 1:10
        loglog(flr, g_dec(j,:), 'LineWidth', 0.2, 'Color', color_spec1);
        loglog(flr, z_dec(j,:), 'LineWidth', 0.2, 'Color', color_spec1);
    end

    grid on;

    % plot main data
    plot(F, PV, 'b', 'LineWidth', 1);

    % text with rotation
    set(gca, 'DefaultTextRotation', 30);

    text(200, 0.015, '1e-5m', 'Color', 'r', 'FontSize', Size_2);
    text(200, 0.15, '1e-4m', 'Color', 'r', 'FontSize', Size_2);
    text(200, 1.5, '1e-3m', 'Color', 'r', 'FontSize', Size_2);


    set(gca, 'DefaultTextRotation', -30);

    text(2500, 8e-2, '1000 m/s2', 'Color', 'r', 'FontSize', Size_2);
    text(2500, 8e-1, '10000 m/s2', 'Color', 'r', 'FontSize', Size_2);
    text(2500, 8, '100000 m/s2', 'Color', 'r', 'FontSize', Size_2);


    set(gca, 'DefaultTextRotation', 0);

    hold off;
end
