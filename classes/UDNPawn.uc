class UDNPawn extends UTPawn;

var float CamOffsetDistance; //Position on Y-axis to lock camera to
var bool game_start;
//override to make player mesh visible by default
simulated event BecomeViewTarget( PlayerController PC )
{
   local UTPlayerController UTPC;

   Super.BecomeViewTarget(PC);

   if (LocalPlayer(PC.Player) != None)
   {
      UTPC = UTPlayerController(PC);
      if (UTPC != None)
      {
         //set player controller to behind view and make mesh visible
         UTPC.SetBehindView(true);
         SetMeshVisibility(UTPC.bBehindView);
         UTPC.bNoCrosshair = true;
      }
   }
}

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
   out_CamLoc = Location;
   out_CamLoc.Y = CamOffsetDistance;

   out_CamRot.Pitch = 0;
   out_CamRot.Yaw = 16384;
   out_CamRot.Roll = 0;
   return true;
}

simulated singular event Rotator GetBaseAimRotation()
{
   local rotator   POVRot;

   POVRot = Rotation;
   if( (Rotation.Yaw % 65535 > 16384 && Rotation.Yaw % 65535 < 49560) ||
      (Rotation.Yaw % 65535 < -16384 && Rotation.Yaw % 65535 > -49560) )
   {
      POVRot.Yaw = 32768;
   }
   else
   {
      POVRot.Yaw = 0;
   }
   
   if( POVRot.Pitch == 0 )
   {
      POVRot.Pitch = RemoteViewPitch << 8;
   }

   return POVRot;
}   

simulated function Tick(float DeltaTime)
{
    local vector tmpLocation;
    tmpLocation = Location;
    if(game_start)
    {
 
     game_start=false;
    // tmpLocation.X = 13360;
    }
    super.Tick(DeltaTime);
    tmpLocation.Y = 500;
    SetLocation(tmpLocation);
}

function bool Dodge(eDoubleClickDir DoubleClickMove)
{
    return false;
}

defaultproperties
{
    game_start=true;
    ControllerClass=class'Tomato.TomatoBot'
    bCanStrafe=false
    MaxStepHeight=50.0
    MaxJumpHeight=500
    JumpZ=550
   CamOffsetDistance=0.0
}