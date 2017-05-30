function [ result ] = uartinterface(pressure, port)
%UARTINTERFACE Summary of this function goes here
%   Detailed explanation goes here
    UART = instrfind('Type', 'serial', 'Port', port, 'Tag', '');
    if isempty(UART)
        UART = serial(port, 'BaudRate', 460800);
%     else
%         fclose(UART);
    end
    
    fopen(UART(1));
    fwrite(UART, pressure, 'int16', 'async');
    UART.InputBufferSize = 16000;
    readasync(UART);
    sleep(2);
    result = fread(UART, s.BytesAvailable/2, 'int16');
    fclose(UART);
    delete(UART);

end

