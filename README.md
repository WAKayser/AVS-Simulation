# AVS-Simulation
MATLAB simulation of sound localalization with an array of Acoustic Vector Sensors

## How to generate data:

1) Create an array of events. This is done using structures. And infinitely many can be added afterwards. At this time cosines, impulses, whitenoise and external sources can be used. The syntax used for this looks like the following line. Using up and down a simple windowing function can be used to ramp the signal up and down. 

       eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'exty', 0,'extfs', 0, ,'up', 0, 'down', 0,'location', 5+2j);
        
2) Create a matrix of AVS. This can be done with the create array function, which works with stepdistances and rotationdistances. The example makes two sensors, one at 0 and one at 50. Both have the same rotation of pi.

       avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);

3) Then we can evaluate all the input data from the events to generate the waves at the sources. The last argument will be the length of the signal in seconds, this must be longer than the last event plus the delay caused by propagation.

       E = eventgen_multi(eventdata, 1);
       
4) After that we use transform_multi to generate the waveforms that will be shown at the sensors
       
       [Z, Pz] = transform_multi(eventdata, avsdata, E);

5) On top of that noise can be added. the last argument is the snr, if the power of the signal was one.

       N = noisegen(Z, 10);
       Pn = noisegen(Pz, 5);
       
6) Then we can generate the signal that is read out by the avs itself. 

       [P, A] = avsreceiver_multi(N, Pn, avsdata);

## Testing out the detection

We have a MATLAB implementation and a Verilog implementation of the detection algorithm. The matlab is currently the most advanced of the two and has a lot of test scripts to determine parameters. The knowledge from this will be used for the Verilog implementation, which can later be used on a FPGA board and be connected to the AVS. 

For modelsim simulation we have a tool that can run modelsim simulations from matlab. This will be extended to iterate over multiple noise levels and generate some plots. 

## Testing the localization

tbw

## Later steps

Send the data over a wireless link. This will be hard to test, be can be already thought about. 


