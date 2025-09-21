function image_filter_gui
    % Create GUI figure
    fig = figure('Name', 'Image Filter App', 'NumberTitle', 'off', 'Position', [200, 100, 800, 500]);

    % UI elements (Add buttons for all 10 operations)
    uicontrol('Style', 'pushbutton', 'String', 'Load Image', 'Position', [20, 450, 100, 30], 'Callback', @loadImage);
    uicontrol('Style', 'pushbutton', 'String', 'Grayscale', 'Position', [130, 450, 100, 30], 'Callback', @applyGrayscale);
    uicontrol('Style', 'pushbutton', 'String', 'Edge Detection', 'Position', [240, 450, 100, 30], 'Callback', @applyEdge);
    uicontrol('Style', 'pushbutton', 'String', 'Sharpen', 'Position', [350, 450, 100, 30], 'Callback', @applySharpen);
    uicontrol('Style', 'pushbutton', 'String', 'Brightness', 'Position', [460, 450, 100, 30], 'Callback', @applyBrightness);
    uicontrol('Style', 'pushbutton', 'String', 'Contrast', 'Position', [570, 450, 100, 30], 'Callback', @applyContrast);
    uicontrol('Style', 'pushbutton', 'String', 'Invert', 'Position', [680, 450, 100, 30], 'Callback', @applyInvert);
    uicontrol('Style', 'pushbutton', 'String', 'Gaussian Blur', 'Position', [130, 410, 100, 30], 'Callback', @applyBlur);
    uicontrol('Style', 'pushbutton', 'String', 'Threshold', 'Position', [240, 410, 100, 30], 'Callback', @applyThreshold);
    uicontrol('Style', 'pushbutton', 'String', 'Reset', 'Position', [350, 410, 100, 30], 'Callback', @resetImage);

    % Axes to display image
    ax = axes('Units', 'pixels', 'Position', [100, 50, 600, 340]);
    axis(ax, 'off');

    % Variables to store images
    originalImg = [];
    currentImg = [];

    % Callback functions
    function loadImage(~, ~)
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'; '*.*', 'All Files (*.*)'}, 'Select an Image');
        if isequal(file, 0)
            return; % User cancelled the dialog
        end
        filePath = fullfile(path, file);
        originalImg = imread(filePath);
        currentImg = originalImg;
        imshow(currentImg, 'Parent', ax);
    end

    function applyGrayscale(~, ~)
        if isempty(currentImg), return; end
        if size(originalImg, 3) == 3
            currentImg = rgb2gray(originalImg);
        end
        imshow(currentImg, 'Parent', ax);
    end

    function applyEdge(~, ~)
        if isempty(currentImg), return; end
        gray = currentImg;
        if size(gray, 3) == 3, gray = rgb2gray(gray); end
        currentImg = edge(gray, 'Canny');
        imshow(currentImg, 'Parent', ax);
    end

    function applySharpen(~, ~)
        if isempty(currentImg), return; end
        currentImg = imsharpen(currentImg);
        imshow(currentImg, 'Parent', ax);
    end

    function applyBrightness(~, ~)
        if isempty(currentImg), return; end
        currentImg = imadd(currentImg, 20); % Increase brightness
        imshow(currentImg, 'Parent', ax);
    end

    function applyContrast(~, ~)
        if isempty(currentImg), return; end
        currentImg = imadjust(currentImg, stretchlim(currentImg), []);
        imshow(currentImg, 'Parent', ax);
    end

    function applyInvert(~, ~)
        if isempty(currentImg), return; end
        currentImg = imcomplement(currentImg);
        imshow(currentImg, 'Parent', ax);
    end

    function applyBlur(~, ~)
        if isempty(currentImg), return; end
        currentImg = imgaussfilt(currentImg, 2); % Apply Gaussian blur
        imshow(currentImg, 'Parent', ax);
    end

    function applyThreshold(~, ~)
        if isempty(currentImg), return; end
        gray = currentImg;
        if size(gray, 3) == 3, gray = rgb2gray(gray); end
        currentImg = imbinarize(gray);
        imshow(currentImg, 'Parent', ax);
    end

    function resetImage(~, ~)
        if isempty(originalImg), return; end
        currentImg = originalImg;
        imshow(currentImg, 'Parent', ax);
    end
end
