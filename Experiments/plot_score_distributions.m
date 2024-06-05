function [decie] = plot_score_distributions(~, imposter_scores)
    bw = 0.02;
    
    % Calculate mean and variance for imposter scores
    imp_mean = mean(imposter_scores);
    imp_var = var(imposter_scores);

    % Generate x values for the plot
    x = linspace(0, 1, 200);

    % Perform kernel density estimation for imposter scores
    [imposter_density, t2] = ksdensity(imposter_scores, x, 'Bandwidth', bw);

    % Generate legend string for imposters
    imp_legend_str = sprintf('${\\frac{1}{\\pi}\\arccos (\\frac{x_L \\cdot x''_L}{||x_L||||x''_L||} )}$', imp_mean, imp_var);

%        gen_legend_str = sprintf('$||\\frac{x}{||x||}-\\frac{x''^{(j)}}{||x''^{(j)}||}||^2_2$', gen_mean, gen_var);
    imp_legend_str = sprintf('$||\\frac{x_L}{||x_L||}-\\frac{x''^{(j)}_L}{||x''^{(j)}_L||}||^2_2$', imp_mean, imp_var);

    % Plot the distribution curve for imposters
    plot(t2, imposter_density, '-o', 'Color', "#7E2F8E", 'DisplayName', imp_legend_str, 'MarkerSize', 10, 'MarkerIndices', 1:5:length(t2), 'MarkerEdgeColor', "#7E2F8E", 'LineWidth', 3);
  
    % Calculate the separation measure (decie) using imposter statistics
    % Since genuine scores are not considered, the separation measure might be less meaningful
    decie = imp_mean / sqrt(imp_var / 2);

    % Add title and labels
    xlabel('$d_{\theta}$', 'Interpreter', 'latex');
    ylabel('Density');
    
    % Set x limits
    xlim([0 1]);
    ylim([0 15]);

    % Show the legend
    legend(imp_legend_str, 'Interpreter', 'latex');
    hold off;
end
