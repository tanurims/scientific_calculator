function scientific_calculator()

    button_width = 65;
    button_height = 65;
    button_x_spacing = 70;
    button_y_spacing = 70;
    start_x = 20;
    start_y = 500;



    fig = figure('Name', 'Scientific Calculator', 'NumberTitle', 'off', 'Position', [700, 100, 380, 700], 'Color', '#2C3E50');


    display_box = uicontrol('Style', 'edit', 'Position', [18, 590, 350, 65],'FontSize', 18,'BackgroundColor', '#ECF0F1','ForegroundColor', '#2C3E50', 'HorizontalAlignment', 'right', 'Enable', 'inactive');


    buttons = {
        'sin', 'cos', 'tan', 'pi', 'e';
        'sin -1', 'cos -1', 'tan -1', '√', 'exp';
        'x^2', 'x^3', '10^x', 'x^y', '1/x';
        '(', ')', 'n!', 'log', 'ln';
        '7', '8', '9', 'DEL', 'AC';
        '4', '5', '6', '*', '/';
        '1', '2', '3', '+', '-';
        '0', '.', '=', '', ''
    };

    for i = 1:8
        for j = 1:5
            if ~isempty(buttons{i, j})

                button_label = buttons{i, j};


                bg_color = '#3498DB';
                fg_color = '#FFFFFF';


                if i <= 4
                    bg_color = '#2980B9';
                end


                if ismember(button_label, {'0','1','2','3','4','5','6','7','8','9','.'})
                    bg_color = '#34495E';
                end


                if ismember(button_label, {'+','-','*','/','=','^'})
                    bg_color = '#E67E22';
                end


                if ismember(button_label, {'AC','DEL'})
                    bg_color = '#E74C3C';
                end

                uicontrol('Style', 'pushbutton', ...
                         'String', button_label, ...
                         'Position', [start_x + (j-1)*button_x_spacing,start_y - (i-1)*button_y_spacing,button_width, button_height],'FontSize', 14,'BackgroundColor', bg_color,'ForegroundColor', fg_color,'Callback', @(src, event) button_callback(src, display_box));
            end
        end
    end


    function button_callback(src, display_box)
        button_label = get(src, 'String');
        current_text = get(display_box, 'String');

        if strcmp(button_label, 'AC')
            set(display_box, 'String', '');

        elseif strcmp(button_label, 'DEL')
            if ~isempty(current_text)
                set(display_box, 'String', current_text(1:end-1));
            end

        else
            switch button_label
                case 'sin'
                    set(display_box, 'String', [current_text 'sind(']);

                case 'cos'
                    set(display_box, 'String', [current_text 'cosd(']);

                case 'tan'
                    set(display_box, 'String', [current_text 'tand(']);

                case 'sin -1'
                    set(display_box, 'String', [current_text 'sin -1(']);

                case 'cos -1'
                    set(display_box, 'String', [current_text 'cos -1(']);

                case 'tan -1'
                    set(display_box, 'String', [current_text 'tan -1(']);

                case 'x^3'
                    try
                        result = eval([current_text '.^3']);
                        set(display_box, 'String', num2str(result));
                    catch
                        set(display_box, 'String', 'Enter a number first');
                    end

                case 'x^2'
                    try
                        result = eval([current_text '.^2']);
                        set(display_box, 'String', num2str(result));
                    catch
                        set(display_box, 'String', 'Enter a number first');
                    end



                case 'exp'
                    set(display_box, 'String', [current_text 'exp(']);

                case '10^x'
                    set(display_box, 'String', [current_text '10^']);

                case  '√'
                    set(display_box, 'String', [current_text 'sqrt(']);

                case '1/x'
                    try
                        result = 1/eval(current_text);
                        set(display_box, 'String', num2str(result));
                    catch
                        set(display_box, 'String', 'Error');
                    end

                case 'x^y'
                    set(display_box, 'String', [current_text '^']);

                case 'log'
                    set(display_box, 'String', [current_text 'log10(']);

                case 'ln'
                    set(display_box, 'String', [current_text 'ln(']);



                case 'n!'
                    try
                        result = factorial(eval(current_text));
                        set(display_box, 'String', num2str(result));
                    catch
                        set(display_box, 'String', 'Error');
                    end


                case '='
                    try
                        eval_expression = current_text;
                        eval_expression = strrep(eval_expression, 'sin -1(', 'asind(');
                        eval_expression = strrep(eval_expression, 'cos -1(', 'acosd(');
                        eval_expression = strrep(eval_expression, 'tan -1(', 'atand(');
                        eval_expression = strrep(eval_expression, 'ln(', 'log(');


                        result = eval(eval_expression);
                        set(display_box, 'String', num2str(result));
                    catch
                        set(display_box, 'String', 'Error');
                    end

                otherwise
                    set(display_box, 'String', [current_text button_label]);
            end
        end
    end
end
