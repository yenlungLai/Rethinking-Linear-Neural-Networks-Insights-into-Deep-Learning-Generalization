function [decie]=plot_score_distributions2(genuine_scores, imposter_scores)
    bw=0.02;
    % Calculate mean and variance for each score set
    gen_mean = mean(genuine_scores);
    gen_var = var(genuine_scores);
    imp_mean = mean(imposter_scores);
    imp_var = var(imposter_scores);

    % Generate x values for the plot
    x = linspace(0, 1, 200);

    % Perform kernel density estimation
    [genuine_density, t1] = ksdensity(genuine_scores, x,'Bandwidth', bw);
    [imposter_density, t2] = ksdensity(imposter_scores, x,'Bandwidth', bw);

    % Generate legend strings
    gen_legend_str = sprintf('${\\frac{1}{\\pi}\\arccos (\\frac{x \\cdot x''^{(j)}}{||x||||x''^{(j)}||} )}$', gen_mean, gen_var);
    imp_legend_str = sprintf('${\\frac{1}{\\pi}\\arccos (\\frac{x \\cdot -x''^{(j)}}{||x||||-x''^{(j)}||} )}$', imp_mean, imp_var);
% 
%     gen_legend_str = sprintf('$||\\frac{x}{||x||}-\\frac{x''^{(j)}}{||x''^{(j)}||}||^2_2$', gen_mean, gen_var);
%     imp_legend_str = sprintf('$||\\frac{x}{||x||}-\\frac{x''^{(j)}}{||x''^{(j)}||}||^2_2$', imp_mean, imp_var);

    % Plot the distribution curves
     plot(t1, genuine_density, '-s', 'Color', "#0072BD", 'DisplayName', gen_legend_str, 'MarkerSize',10, 'MarkerIndices',1:5:length(t1), 'MarkerEdgeColor',"#0072BD",'LineWidth', 3);
     hold on
    plot(t2, imposter_density,'-o', 'Color', "#A2142F", 'DisplayName', imp_legend_str, 'MarkerSize',10, 'MarkerIndices',1:5:length(t2), 'MarkerEdgeColor',"#A2142F",'LineWidth', 3);

  
    decie=abs(gen_mean-imp_mean)/sqrt( (gen_var+ imp_var)/2);

    % Add title and labels
%     title('Distribution of Hamming and Theta');
    xlabel('$d_{\theta}$','Interpreter', 'latex');
    ylabel('Density');
    
    % Set x limits
    xlim([0 1]);
    ylim([0 30]);
    % Show the legend and plot
    legend(gen_legend_str,imp_legend_str, 'Interpreter', 'latex');
    hold off;
end
