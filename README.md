# AVS-Simulation
MATLAB simulation of sound localalization with an array of Acoustic Vector Sensors

## How to use this simulator:

1) Create an array of events. This is done using structures. And infinitely many can be added afterwards. At this time cosines, impulses, whitenoise and external sources can be used. The syntax used for this looks like the following line.

       eventdata(1) = struct('type','pulse','delay',0.25,'duration',0.1,'amplitude',1, 'freq', 0, 'exty', 0,'extfs', 0, 'location', 500+200j);
        
2) Create a matrix of AVS. This can be done with the create array function, which works with stepdistances and rotationdistances. The example makes two sensors, one at 0 and one at 50. Both have the same rotation of pi.

       avsdata(:,:,1) = create_array(0, 50, 2, pi, 0);

3) Then we can evaluate all the input data from the events to generate the waves at the sources. The last argument will be the length of the signal in seconds. 

       E = eventgen_multi(eventdata, 1);
       
4) After that we use transform_multi to generate the waveforms that will be shown at the sensors
       
       Z = transform_multi(eventdata, avsdata, E);

5) On top of that noise can be added. the last argument is the snr, if the power of the signal was one.

       N = noisegen(Z, 200);
       
6) Then we can generate the signal that is read out by the avs itself. 

       [P, A] = avsreceiver_multi(N, avsdata);

7) The next two steps are to create eventdetectors and sound localizators. 

       your code here
