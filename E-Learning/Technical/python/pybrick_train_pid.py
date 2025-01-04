from pybricks.hubs import CityHub
from pybricks.pupdevices import DCMotor, Light, ColorDistanceSensor
from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch

hub = CityHub()

sens_dist = ColorDistanceSensor(Port.A)
motor = DCMotor(Port.B)

dist_ref = 50 # this is in cm

# determine the proportional path 

while 1:
    distance = sens_dist.distance()
    # compute the error
    error = dist_ref - distance

    K_p = error*(3/5)

    motor.dc(K_p)
