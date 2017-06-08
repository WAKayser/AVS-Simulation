function [ result ] = uartinterface(pressure, port)
%UARTINTERFACE Summary of this function goes here
%   Detailed explanation goes here
    UART = instrfind('Type', 'serial', 'Port', port, 'Tag', '');
    if isempty(UART)
        UART = serial(port, 'BaudRate', 1000000);
    else
        fclose(UART);
    end
        UART.InputBufferSize = 160000;
    UART.OutputBufferSize = 320000;
    UART = UART(1);
    % uart magic die nog lang niet werkt
    fopen(UART);
    fwrite(UART, pressure, 'int16', 'async');

    readasync(UART);
    pause(2);
    result = fread(UART, UART.BytesAvailable/2, 'int16');
    fclose(UART);
    delete(UART);

end

