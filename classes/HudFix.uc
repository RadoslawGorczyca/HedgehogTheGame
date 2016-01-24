Class HudFix Extends UDKHUD;

var int timer;
var int pickups_counter;
var int base_number_of_pickups;
var name Pickup;
var bool victory;
var bool lose;

simulated function PostBeginPlay()
{
   addtime();
}

event Postrender()
{
    Canvas.SetPos(10,10);
    Canvas.SetDrawColor(255,255,255,255);
    Canvas.Font=Font'UI_Fonts_Final.menus.Fonts_AmbexHeavy';
    Canvas.SetPos(10,10);
    Canvas.DrawText("Time:");
    Canvas.SetPos(110,10);
    Canvas.DrawText(timer); 
    Canvas.SetPos(10,70);
    Canvas.DrawText("Apples:");
    Canvas.SetPos(110,70);
    if(base_number_of_pickups-pickups_counter<100)
    {
        Canvas.DrawText("0");
        Canvas.SetPos(130,70);
        if(base_number_of_pickups-pickups_counter<10)
        {         
            Canvas.DrawText("0"); 
            Canvas.SetPos(150,70);
        }
    }
    Canvas.DrawText(base_number_of_pickups-pickups_counter);   
    Canvas.SetPos(170,70);
    Canvas.DrawText("/"); 
    Canvas.SetPos(190,70);
    Canvas.DrawText(base_number_of_pickups);
   if(lose || victory)
  {
      Canvas.Font=Font'UI_Fonts.Fonts.UI_Fonts_AmbexHeavy36';
      Canvas.SetPos(210,130);
      if(victory)
      {
        Canvas.DrawText("YOU WON!");     
      }
    else
    {
       Canvas.DrawText("YOU LOSE!");  
    }
  } 
}

function addtime()
{
    if(victory == false)
        timer--;
    SetTimer(1,true,'addtime2');
    CheckForTimeEnd();
}

function addtime2()
{
    if(victory == false)
        timer--;
    CheckForTimeEnd();
}

  function CheckForTimeEnd()
{
   local Actor A;
  if(timer<=0)
    {
        lose=true;
        Reload();  
    } 
 
    pickups_counter=0;

   foreach AllActors(class 'Actor',A)
   {
       if(A.tag == Pickup)
        pickups_counter++;
   } 
    if(base_number_of_pickups==0)
    base_number_of_pickups=pickups_counter;
    if(pickups_counter==0)
        victory=true;
}

exec function Reload()
{
    ConsoleCommand("open " $ WorldInfo.GetMapName(true)); 
}

DefaultProperties
{
    lose = false;
    victory = false;
    Pickup="pickup";
    base_number_of_pickups=0;
    pickups_counter=0;
    timer = 420;
}