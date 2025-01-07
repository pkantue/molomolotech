from pybricks.hubs import CityHub
from pybricks.pupdevices import DCMotor, Light, ColorDistanceSensor, Remote
from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch

hub = CityHub()

sens_dist = ColorDistanceSensor(Port.A)
motor = DCMotor(Port.B)

dist_ref = 50 # this is in cm
I_err = 0 # initialze the integral error 
# determine the proportional path 

while 1:
    distance = sens_dist.distance()
    
    # enter safeguard to unintended movements
    if distance == 100:
        K_I = 0
        K_P = 0
        motor.brake
    else:
        # compute the error
        error = dist_ref - distance
        I_err = I_err + error/2000

        K_P = error*(3/5) # proportional gain
        K_I = I_err # integral gain

        if K_I > 80:
            K_I = 80
    
        if K_I < -80:
            K_I = -80
    
        motor.dc(K_P + K_I)
    
