function [Dmg] = AttackCalc(Atk,Def)
 
AtkVariance = Atk * ((30 - randi(60,1))/100);
CritChance = randi(100,1)
CritAtk = 0;
if CritChance == 69 | CritChance == 42
    CritAtk = Atk * 3.00;
end 
Dmg = (Atk + AtkVariance + CritAtk)/Def;
