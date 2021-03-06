//SALMON 1 AUTOMATION V 1.2

//TOTALLY INSPIRED BY FALCON HEAVY, HOWEVER THIS IS DESIGNED FOR THE ATTACHED SSTO.
//THEREFORE THE ATTACHED CRAFT SHALL BE NAMED "Salmon 1", AS ITS DRIVE IS TO GET UP RIVER OR DIE TRYIN'.
//ENJOY!

CLEARSCREEN.

PRINT "--------------------------------------------".
PRINT "Salmon 1 Launch and Landing Automation V1.2.".
PRINT "                By Drobie22.                ".
PRINT "--------------------------------------------".

SET WARPMODE TO "PHYSICS".
SET WARP TO 1.

//COUNTDOWN
PRINT "-------------".
PRINT "Launching in:".
PRINT "-------------".
FROM {local countdown is 10.} UNTIL countdown = 0 STEP {SET countdown to countdown - 1.} DO {
    PRINT "..." + countdown.
    WAIT 1. 
}

PRINT "--------------------------------".
PRINT "Guidance and Power are Internal.".

TOGGLE BAYS.
PRINT "Guidance Bay Closed.".


//INITIAL THROTTLE
LOCK THROTTLE TO 1.0.  

//TWR CODE
WHEN ((SHIP:AVAILABLETHRUST)/(SHIP:MASS*9.81)) >= 2 THEN {
LOCK THROTTLE TO (2*SHIP:MASS*9.81)/(SHIP:AVAILABLETHRUST).
    }

UNTIL SHIP:MAXTHRUST > 0 {
    WAIT 1. 
    PRINT "Launch Stage activated.".
    PRINT "Clamps Released.".
    STAGE. 
    PRINT "--------".
    PRINT "Liftoff.".
    PRINT "--------".
}

//FLIGHTPATH

//ALTITUDE SPECIFICS
SET A TO 5000.
SET B TO 6000.
SET C TO 7000.
SET D TO 8000.
SET E TO 9000.
SET F TO 10000.
SET G TO 11000.
SET H TO 12000.
SET I TO 13000.
SET J TO 16500.
SET K TO 20000.
SET L TO 30000.
SET M TO 40000.
SET N TO 50000.
SET O TO 55000.
SET Z TO 100000.

SET MYSTEER TO HEADING(90,90).
LOCK STEERING TO MYSTEER. 
UNTIL SHIP:APOAPSIS >= Z { 

    IF SHIP:VELOCITY:SURFACE:MAG < 100 {
       
        SET MYSTEER TO HEADING(90,90).

    } ELSE IF SHIP:VELOCITY:SURFACE:MAG >= 100 AND SHIP:VELOCITY:SURFACE:MAG < 200 {
        SET MYSTEER TO HEADING(90,80).
        SET WARP TO 3.
        PRINT "Pitching to 80 degrees." AT(0,25). 

    } ELSE IF SHIP:ALTITUDE >= A AND SHIP:ALTITUDE < B {
        SET MYSTEER TO HEADING(90,75).
        PRINT "Pitching to 75 degrees." AT(0,25).
       
    } ELSE IF SHIP:ALTITUDE >= B AND SHIP:ALTITUDE < C {
        SET MYSTEER TO HEADING(90,70).
        PRINT "Pitching to 70 degrees." AT(0,25).
      
    } ELSE IF SHIP:ALTITUDE >= C AND SHIP:ALTITUDE < D {
        SET MYSTEER TO HEADING(90,65).
        PRINT "Pitching to 65 degrees." AT(0,25).
   
    } ELSE IF SHIP:ALTITUDE >= D AND SHIP:ALTITUDE < E {
        SET MYSTEER TO HEADING(90,60).
        PRINT "Pitching to 60 degrees." AT(0,25).
      
    } ELSE IF SHIP:ALTITUDE >= E AND SHIP:ALTITUDE < F {
        SET MYSTEER TO HEADING(90,55).
        PRINT "Pitching to 55 degrees." AT(0,25).
       
    } ELSE IF SHIP:ALTITUDE >= F AND SHIP:ALTITUDE < G {
        SET MYSTEER TO HEADING(90,50).
        PRINT "Pitching to 50 degrees." AT(0,25).
  
    } ELSE IF SHIP:ALTITUDE >= G AND SHIP:ALTITUDE < H {
        SET MYSTEER TO HEADING(90,45).
        PRINT "Pitching to 45 degrees." AT(0,25).
   
    } ELSE IF SHIP:ALTITUDE >= H AND SHIP:ALTITUDE < I {
        SET MYSTEER TO HEADING(90,40).
        PRINT "Pitching to 40 degrees." AT(0,25).

    } ELSE IF SHIP:ALTITUDE >= I AND SHIP:ALTITUDE < J {
        SET MYSTEER TO HEADING(90,35).
        PRINT "Pitching to 35 degrees." AT(0,25).
       
    } ELSE IF SHIP:ALTITUDE >= J AND SHIP:ALTITUDE < K {
        SET MYSTEER TO HEADING(90,30).
        PRINT "Pitching to 30 degrees." AT(0,25).
      
    } ELSE IF SHIP:ALTITUDE >= K AND SHIP:ALTITUDE < L {
        SET MYSTEER TO HEADING(90,25).
        PRINT "Pitching to 25 degrees." AT(0,25).
   
    } ELSE IF SHIP:ALTITUDE >= L AND SHIP:ALTITUDE < M {
        SET MYSTEER TO HEADING(90,20).
        PRINT "Pitching to 20 degrees." AT(0,25).
      
    } ELSE IF SHIP:ALTITUDE >= M AND SHIP:ALTITUDE < N {
        SET MYSTEER TO HEADING(90,15).
        PRINT "Pitching to 15 degrees." AT(0,25).
       
    } ELSE IF SHIP:ALTITUDE >= N AND SHIP:ALTITUDE < O {
        SET MYSTEER TO HEADING(90,10).
        PRINT "Pitching to 10 degrees." AT(0,25).
  
    } ELSE IF SHIP:ALTITUDE >= O {
        SET MYSTEER TO HEADING(90,5).
        PRINT "Pitching to 5 degrees." AT (0,25).
   
    }

}

PRINT "                         " AT (0,25).
PRINT "Apoapsis reached, cutting throttle.".
LOCK THROTTLE TO 0.
LOCK STEERING TO SHIP:PROGRADE.

WAIT UNTIL SHIP:ALTITUDE >= 70000.
SET WARPMODE TO "PHYSICS".
SET WARP TO 0.
PRINT "-----------------".
PRINT "Welcome to Space.".
PRINT "-----------------".
WAIT 5.
STAGE.
PRINT "Fairing Deploy.".
WAIT 5.
SET WARPMODE TO "PHYSICS".
SET WARP TO 3.

//MANEUVER NODE
SET TARGETV TO SQRT(SHIP:BODY:MU/(SHIP:ORBIT:BODY:RADIUS + SHIP:ORBIT:APOAPSIS)). 
SET APVEL TO SQRT(((1 - SHIP:ORBIT:ECCENTRICITY) * SHIP:ORBIT:BODY:MU) / ((1 + SHIP:ORBIT:ECCENTRICITY) * SHIP:ORBIT:SEMIMAJORAXIS)). 
SET DV TO TARGETV - APVEL. 
SET ND TO NODE(TIME:SECONDS + ETA:APOAPSIS, 0, 0, DV). 
ADD ND. 

SET NP TO ND:DELTAV. 
LOCK STEERING TO NP.

SET MAX_ACC TO SHIP:MAXTHRUST/SHIP:MASS.
SET BURN_DURATION TO ND:DELTAV:MAG/MAX_ACC.

//WAIT UNTIL NODE
WAIT UNTIL ND:ETA <= (BURN_DURATION/2 + 10).
PRINT "Circularization Burn Commencing.".
SET WARPMODE TO "PHYSICS".
SET WARP TO 0.
WAIT UNTIL VANG(NP, SHIP:FACING:VECTOR) < 0.25.
WAIT UNTIL ND:ETA <= (BURN_DURATION/2).
SET TSET TO 0.
LOCK THROTTLE TO TSET.
SET DONE TO FALSE.
SET DV0 TO ND:DELTAV.
LOCK STEERING TO NP.
UNTIL DONE
{
    //RECALCULATE CURRENT MAX_ACCELERATION, AS IT CHANGES WHILE WE BURN THROUGH FUEL
    SET MAX_ACC TO SHIP:MAXTHRUST/SHIP:MASS.
    LOCK STEERING TO NP.

    //THROTTLE IS 100% UNTIL THERE IS LESS THAN 1 SECOND OF TIME LEFT TO BURN
    //WHEN THERE IS LESS THAN 1 SECOND - DECREASE THE THROTTLE LINEARLY
    SET TSET TO MIN(ND:DELTAV:MAG/MAX_ACC, 1).
    LOCK STEERING TO NP.

    //HERE'S THE TRICKY PART, WE NEED TO CUT THE THROTTLE AS SOON AS OUR ND:DELTAV AND INITIAL DELTAV START FACING OPPOSITE DIRECTIONS
    //THIS CHECK IS DONE VIA CHECKING THE DOT PRODUCT OF THOSE 2 VECTORS
    IF VDOT(DV0, ND:DELTAV) < 0
    {
        PRINT "End burn, remain dv " + round(nd:deltav:mag,1) + "m/s, vdot: " + round(vdot(dv0, nd:deltav),1).
        LOCK THROTTLE TO 0.
        BREAK.
    }

    IF ND:DELTAV:MAG < 0.1
    {
        PRINT "Finalizing burn.".
        WAIT UNTIL VDOT(DV0, ND:DELTAV) < 0.5.
        LOCK THROTTLE TO 0.
        PRINT "End burn.".
        SET DONE TO TRUE.
    }
}
UNLOCK STEERING.
UNLOCK THROTTLE.
WAIT 1.
REMOVE ND.

//PAYLOAD DEPLOY
WAIT 5.
PRINT "---------------------------------------".
PRINT "Parking Orbit Achieved. Payload Deploy.".
PRINT "---------------------------------------".
STAGE.
WAIT 5.
CLEARSCREEN.

//LANDING

SET BURNLONG TO 116. 
SET RUNWAYLONG TO 285.275833129883. 
SET RUNWAYLAT TO -0.048591406236738.

PRINT "----------------------".
PRINT "Deorbit script loaded.".
PRINT "----------------------".
WAIT 2.
SET WARPMODE TO "RAILS".
SET WARP TO 4. 
UNTIL ABS(RUNWAYLONG - BURNLONG - SHIP:LONGITUDE) < 20  { 
	
	PRINT  "Deorbit in: " + ROUND((RUNWAYLONG - BURNLONG - SHIP:LONGITUDE),2) + " degrees." AT(0,5).
	WAIT 1.
}.
SET WARP TO 0.  

LOCK STEERING TO RETROGRADE.  
PRINT "                                                                  " AT(0,5).
PRINT "Pointing Engines to Reverse.".
SET WARPMODE TO "PHYSICS".
SET WARP TO 3.

UNTIL VANG(SHIP:FACING:VECTOR,RETROGRADE:VECTOR) < 0.2
AND  RUNWAYLONG - BURNLONG - SHIP:LONGITUDE < 0.2 {	

	Print  "Deorbit in: " + ROUND((RUNWAYLONG - BURNLONG - SHIP:LONGITUDE),2) + " degrees." AT (0,4).
	WAIT 1.
}.

IF RUNWAYLONG - BURNLONG - SHIP:LONGITUDE < -1 
	PRINT "Late for burn! Ship turns too slow.".

PRINT "Oriented for burn.".
SET WARP TO 0.
PRINT  "Deorbiting at: " + ROUND((RUNWAYLONG -  SHIP:LONGITUDE),2) + " degrees from KSC.".

//DE-ORBIT BURN
LOCK THROTTLE TO 0.25.
WAIT UNTIL PERIAPSIS <10000.
LOCK THROTTLE TO 0.05.
WAIT UNTIL Periapsis < 1000. 
LOCK THROTTLE TO 0.
LOCK STEERING TO RETROGRADE.
PRINT "Burn Complete.".

IF (SHIP:STATUS = "SUB_ORBITAL") OR (SHIP:STATUS = "FLYING") { 
PRINT "Beginning Controlled Free-Fall.".
SET WARPMODE TO "PHYSICS".
SET WARP TO 3.
}

BRAKES ON.

//GLIDE PARAMETERS, CHANGE THESE IF NEEDED. 

LOCK STEERING TO HEADING(270,5, 0).

WAIT UNTIL SHIP:ALTITUDE <= 70000.
PRINT "---------------------".
PRINT "Atmospheric Re-entry.".
PRINT "---------------------".

WAIT UNTIL SHIP:ALTITUDE <=35000.
LOCK STEERING TO HEADING(270,-5, 0).

WAIT UNTIL SHIP:ALTITUDE <=20000.
LOCK STEERING TO HEADING(270,5, 0).

WAIT UNTIL SHIP:Velocity:Surface:MAG < 1500.
LOCK STEERING TO RETROGRADE.

WAIT UNTIL SHIP:Velocity:Surface:MAG < 1000. 
PRINT "Reentry complete. Aiming for KSC.".
CHUTESSAFE ON.
TOGGLE BAYS.

WAIT UNTIL SHIP:Velocity:Surface:MAG < 800. 
CHUTES ON.

WHEN ALT:RADAR <= 200 THEN {
PRINT "Landing Gear Deploying.".
GEAR ON.
SET WARP TO 0.
}.

WHEN ALT:RADAR <=100 THEN {
SET MYSTEER TO HEADING(90,90).
SET THROTTLE TO (8/((SHIP:AVAILABLETHRUST)/(SHIP:MASS))).
}

WAIT UNTIL SHIP:Velocity:Surface:MAG < 7. 
SET THROTTLE TO (1.5/((SHIP:AVAILABLETHRUST)/(SHIP:MASS))).

WAIT UNTIL SHIP:VELOCITY:SURFACE:MAG < 2.
SET THROTTLE TO 0.
PRINT "-----------------------------------------".
PRINT "Ship Landing Complete. See You Next Time!".
PRINT "-----------------------------------------".
WAIT 1.

//DISCLAIMER: CODE HAS BEEN ADAPTED FROM A NUMBER OF SOURCES. PLEASE CONTACT ME WITH ANY QUESTIONS OR COMMENTS. THANKS!

