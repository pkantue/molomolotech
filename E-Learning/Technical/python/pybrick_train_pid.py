from pybricks.hubs import CityHub
from pybricks.pupdevices import DCMotor, Light, ColorDistanceSensor
from pybricks.parameters import Button, Color, Direction, Port, Side, Stop
from pybricks.robotics import DriveBase
from pybricks.tools import wait, StopWatch

hub = CityHub()

distance = ColorDistanceSensor(Port.A)
motor = DCMotor(Port.B)

dist_ref = 5 # this is in cm

# determine the proportional path 

motor.dc(20)

wait(1000)
